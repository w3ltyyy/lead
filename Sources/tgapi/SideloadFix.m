#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <objc/runtime.h>
#import <os/lock.h>

// Built-in replacement for the "sideload fixer" dylib people inject next to Lead.
//
// A re-signed Telegram usually lacks its App Group (group.<bundle id>) and iCloud
// entitlements: -containerURLForSecurityApplicationGroupIdentifier: returns nil and
// CKContainer setup throws, and Telegram crashes on launch. The old fixer pointed
// every group at <Documents>/AppGroup of the calling process, even when the real
// group worked. App and notification extension then each got a private folder, the
// extension never saw the account, and pushes showed "You have a new message".
//
// Here the real container wins: the requested group if the signature has it, else
// any group the signature does have (shared by the app and its extensions when the
// signer sets one), and only then the private folder. CloudKit is stubbed only when
// there is no iCloud entitlement. Runs in every process Lead is injected into,
// extensions included, and stays out of the way if the old fixer is loaded too.

typedef struct __SecTask *LeadSecTaskRef;

static id LeadEntitlement(NSString *key) {
  static LeadSecTaskRef (*createFromSelf)(CFAllocatorRef);
  static CFTypeRef (*copyValue)(LeadSecTaskRef, CFStringRef, CFErrorRef *);
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    void *security = dlopen("/System/Library/Frameworks/Security.framework/Security", RTLD_LAZY);
    if (!security) return;
    createFromSelf = (LeadSecTaskRef (*)(CFAllocatorRef))dlsym(security, "SecTaskCreateFromSelf");
    copyValue = (CFTypeRef (*)(LeadSecTaskRef, CFStringRef, CFErrorRef *))dlsym(security, "SecTaskCopyValueForEntitlement");
  });
  if (!createFromSelf || !copyValue) return nil;
  LeadSecTaskRef task = createFromSelf(kCFAllocatorDefault);
  if (!task) return nil;
  CFTypeRef value = copyValue(task, (__bridge CFStringRef)key, NULL);
  CFRelease(task);
  return CFBridgingRelease(value);
}

static NSArray<NSString *> *LeadEntitledAppGroups(void) {
  static NSArray<NSString *> *groups;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    id value = LeadEntitlement(@"com.apple.security.application-groups");
    NSMutableArray *result = [NSMutableArray array];
    if ([value isKindOfClass:[NSArray class]]) {
      for (id group in value) {
        if ([group isKindOfClass:[NSString class]] && [group length]) [result addObject:group];
      }
    }
    groups = result;
  });
  return groups;
}

static BOOL LeadHasICloudEntitlement(void) {
  id containers = LeadEntitlement(@"com.apple.developer.icloud-container-identifiers");
  return [containers isKindOfClass:[NSArray class]] && [containers count] > 0;
}

static BOOL LeadIsAppExtension(void) {
  return [[NSBundle mainBundle].bundlePath hasSuffix:@".appex"];
}

// Swaps `selector` on `cls`. When the method is inherited, it's added to `cls`
// instead so the superclass keeps its own implementation.
static BOOL LeadSwizzle(Class cls, SEL selector, IMP replacement, IMP *original) {
  if (!cls) return NO;
  Method method = class_getInstanceMethod(cls, selector);
  if (!method) return NO;
  IMP previous = method_getImplementation(method);
  if (!class_addMethod(cls, selector, replacement, method_getTypeEncoding(method))) {
    previous = method_setImplementation(method, replacement);
  }
  if (original) *original = previous;
  return YES;
}

#pragma mark - App Group

static NSURL *(*sOrigContainerURL)(id, SEL, NSString *);
static NSMutableDictionary<NSString *, NSURL *> *sResolvedGroups;
// requested group → the group actually used (for diagnostics)
static NSMutableDictionary<NSString *, NSString *> *sChosenGroups;
static os_unfair_lock sResolvedLock = OS_UNFAIR_LOCK_INIT;

static NSURL *LeadPrivateGroupFolder(void) {
  NSURL *documents = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
  NSURL *folder = [documents URLByAppendingPathComponent:@"AppGroup" isDirectory:YES];
  [[NSFileManager defaultManager] createDirectoryAtURL:folder withIntermediateDirectories:YES attributes:nil error:nil];
  return folder;
}

// A signer usually hands every app it signs the same few groups (and sometimes the
// same bundle id). Telegram, Turrit and Swiftgram then shared one folder: one
// account, one database written by several apps. Each client gets its own folder
// inside the shared one, named after the group it asked for; its notification
// extension asks for the same name and lands in the same place.
static NSURL *LeadClientFolder(NSURL *base, NSString *group) {
  NSString *name = [[group componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/:"]] componentsJoinedByString:@"_"];
  NSURL *folder = [[base URLByAppendingPathComponent:@"Lead" isDirectory:YES] URLByAppendingPathComponent:name isDirectory:YES];
  [[NSFileManager defaultManager] createDirectoryAtURL:folder withIntermediateDirectories:YES attributes:nil error:nil];
  return folder;
}

static BOOL LeadHasTelegramData(NSURL *folder) {
  return [[NSFileManager defaultManager] fileExistsAtPath:[folder.path stringByAppendingPathComponent:@"telegram-data"]];
}

// Moves a client's data from `from` (the shared root a 2.0 build used, or the old
// fixer's <Documents>/AppGroup) into its own folder. The first client launched
// after the update claims it, so whoever was logged in stays logged in there;
// the others start clean. Main app only: extensions just read.
static void LeadClaimData(NSURL *from, NSURL *client) {
  if (LeadIsAppExtension() || LeadHasTelegramData(client) || !LeadHasTelegramData(from)) return;
  NSFileManager *fm = [NSFileManager defaultManager];
  for (NSString *item in [fm contentsOfDirectoryAtPath:from.path error:nil] ?: @[]) {
    if ([item isEqualToString:@"Lead"] || [item isEqualToString:@"lead-extensions"]) continue;
    NSString *to = [client.path stringByAppendingPathComponent:item];
    if ([fm fileExistsAtPath:to]) continue;
    NSError *error = nil;
    if (![fm moveItemAtPath:[from.path stringByAppendingPathComponent:item] toPath:to error:&error]) {
      NSLog(@"[Lead] SideloadFix: moving %@ failed: %@", item, error);
    }
  }
  NSLog(@"[Lead] SideloadFix: moved existing data from %@ into %@", from.path, client.path);
}

// Extensions leave a note in the client folder, so the app's diagnostics can tell
// that Lead ran inside them and which group they landed in.
static void LeadMarkExtension(NSURL *container, NSString *group) {
  if (!LeadIsAppExtension()) return;
  NSString *folder = [container.path stringByAppendingPathComponent:@"lead-extensions"];
  [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
  NSString *name = [NSBundle mainBundle].bundlePath.lastPathComponent ?: @"extension";
  NSString *note = [NSString stringWithFormat:@"%.0f %@", [NSDate date].timeIntervalSince1970, group];
  [note writeToFile:[folder stringByAppendingPathComponent:name] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// The installed app, as "<install UUID>-<Name>.app": the same string in the app and
// in its extensions (they live inside its bundle), whatever bundle ids or group
// names a signer gave them.
static NSString *LeadHostKey(void) {
  NSString *path = [NSBundle mainBundle].bundlePath;
  if (LeadIsAppExtension()) path = path.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent;
  NSString *key = [NSString stringWithFormat:@"%@-%@", path.stringByDeletingLastPathComponent.lastPathComponent, path.lastPathComponent];
  return [[key componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/:"]] componentsJoinedByString:@"_"];
}

// The app records which folder is its own; an extension follows that record even
// when the group name it asks for differs from the app's.
static void LeadRecordHost(NSURL *base, NSURL *client) {
  if (LeadIsAppExtension()) return;
  NSString *folder = [base.path stringByAppendingPathComponent:@"Lead/_hosts"];
  [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
  [client.lastPathComponent writeToFile:[folder stringByAppendingPathComponent:LeadHostKey()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

static NSString *LeadRecordedHostFolder(NSURL *base) {
  NSString *record = [base.path stringByAppendingPathComponent:[@"Lead/_hosts" stringByAppendingPathComponent:LeadHostKey()]];
  NSString *name = [NSString stringWithContentsOfFile:record encoding:NSUTF8StringEncoding error:nil];
  return name.length ? name : nil;
}

// Every extension that runs leaves "<what it asked for> → <folder it got>" in one
// shared place, so the app's diagnostics can show a mismatch.
static void LeadNoteExtension(NSURL *base, NSString *requested, NSURL *client) {
  if (!LeadIsAppExtension() || !base) return;
  NSString *folder = [base.path stringByAppendingPathComponent:@"Lead/_extensions"];
  [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
  NSString *note = [NSString stringWithFormat:@"%.0f asked=%@ got=%@ data=%d", [NSDate date].timeIntervalSince1970, requested,
                    client.lastPathComponent, LeadHasTelegramData(client)];
  [note writeToFile:[folder stringByAppendingPathComponent:[NSBundle mainBundle].bundlePath.lastPathComponent ?: @"extension"]
         atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// A folder for Lead's own notes that the app and its extensions both reach, whatever
// group names they ask Telegram's questions with: the settings an extension must
// follow, and what it saw while the app wasn't running. nil without a shared group.
NSString *LeadSharedNotesPath(void) {
  static NSString *cached;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    SEL selector = @selector(containerURLForSecurityApplicationGroupIdentifier:);
    NSFileManager *fm = [NSFileManager defaultManager];
    // Lead's constructors run in no fixed order; before the swizzle the method is the original.
    NSURL *(*original)(id, SEL, NSString *) = sOrigContainerURL ?: (NSURL *(*)(id, SEL, NSString *))[fm methodForSelector:selector];
    NSURL *chosen = nil;
    for (NSString *group in [LeadEntitledAppGroups() sortedArrayUsingSelector:@selector(compare:)]) {
      NSURL *root = original(fm, selector, group);
      if (!root) continue;
      if (!chosen) chosen = root;
      if (LeadRecordedHostFolder(root)) { chosen = root; break; }
    }
    if (!chosen) return;
    NSString *folder = [chosen.path stringByAppendingPathComponent:[@"Lead/_shared" stringByAppendingPathComponent:LeadHostKey()]];
    [fm createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    cached = folder;
  });
  return cached;
}

static NSURL *LeadResolveContainer(id self, SEL _cmd, NSString *group) {
  NSURL *url = sOrigContainerURL(self, _cmd, group);
  if (url) {
    // The signature has this client's own group: nothing to share, nothing to move
    // except what the old fixer left in <Documents>/AppGroup.
    LeadClaimData(LeadPrivateGroupFolder(), url);
    LeadMarkExtension(url, group);
    return url;
  }
  NSURL *legacyPrivate = LeadPrivateGroupFolder();
  // The app and each extension resolve this on their own, and their entitlements
  // may list the groups in different orders, so the choice must not depend on it:
  // the group holding this client's folder, else one with unclaimed data at its
  // root, else the first by name.
  NSMutableArray<NSString *> *candidates = [NSMutableArray array];
  NSMutableDictionary<NSString *, NSURL *> *urls = [NSMutableDictionary dictionary];
  for (NSString *entitled in [LeadEntitledAppGroups() sortedArrayUsingSelector:@selector(compare:)]) {
    if ([entitled isEqualToString:group]) continue;
    NSURL *candidate = sOrigContainerURL(self, _cmd, entitled);
    if (!candidate) continue;
    [candidates addObject:entitled];
    urls[entitled] = candidate;
  }
  NSString *chosen = nil;
  NSString *name = [[group componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/:"]] componentsJoinedByString:@"_"];
  // An extension goes where its app went.
  if (LeadIsAppExtension()) {
    for (NSString *entitled in candidates) {
      NSString *recorded = LeadRecordedHostFolder(urls[entitled]);
      if (recorded) {
        NSURL *client = [[urls[entitled] URLByAppendingPathComponent:@"Lead"] URLByAppendingPathComponent:recorded isDirectory:YES];
        os_unfair_lock_lock(&sResolvedLock);
        sChosenGroups[group] = entitled;
        os_unfair_lock_unlock(&sResolvedLock);
        LeadNoteExtension(urls[entitled], group, client);
        LeadMarkExtension(client, entitled);
        return client;
      }
    }
  }
  for (NSString *entitled in candidates) {
    NSURL *existing = [[urls[entitled] URLByAppendingPathComponent:@"Lead"] URLByAppendingPathComponent:name];
    if (LeadHasTelegramData(existing)) { chosen = entitled; break; }
  }
  if (!chosen) {
    for (NSString *entitled in candidates) {
      if (LeadHasTelegramData(urls[entitled])) { chosen = entitled; break; }
    }
  }
  if (!chosen) chosen = candidates.firstObject;

  NSURL *base = chosen ? urls[chosen] : legacyPrivate;
  NSURL *client = LeadClientFolder(base, group);
  if (chosen) {
    LeadClaimData(base, client);
    LeadRecordHost(base, client);
    LeadNoteExtension(base, group, client);
    os_unfair_lock_lock(&sResolvedLock);
    sChosenGroups[group] = chosen;
    os_unfair_lock_unlock(&sResolvedLock);
    NSLog(@"[Lead] SideloadFix: %@ → %@/Lead/%@", group, chosen, client.lastPathComponent);
  } else {
    NSLog(@"[Lead] SideloadFix: %@ → private folder (no app group in the signature)", group);
  }
  LeadClaimData(legacyPrivate, client);
  LeadMarkExtension(client, chosen ?: @"private");
  return client;
}

static NSURL *LeadContainerURL(id self, SEL _cmd, NSString *group) {
  if (![group isKindOfClass:[NSString class]] || group.length == 0) {
    return sOrigContainerURL(self, _cmd, group);
  }
  os_unfair_lock_lock(&sResolvedLock);
  NSURL *cached = sResolvedGroups[group];
  os_unfair_lock_unlock(&sResolvedLock);
  if (cached) return cached;

  NSURL *url = LeadResolveContainer(self, _cmd, group);
  if (url) {
    os_unfair_lock_lock(&sResolvedLock);
    sResolvedGroups[group] = url;
    os_unfair_lock_unlock(&sResolvedLock);
  }
  return url;
}

#pragma mark - CloudKit

// CKContainer's private setup throws without the iCloud entitlement; nil makes
// Telegram skip iCloud features instead of crashing.
static id LeadCKSetup(__unsafe_unretained id self, SEL _cmd, __unsafe_unretained id containerID, __unsafe_unretained id options) {
  return nil;
}

static id LeadCKInit(__unsafe_unretained id self, SEL _cmd, __unsafe_unretained id identifier) {
  return nil;
}

static BOOL sCloudKitHooked = NO;

static void LeadHookCloudKitIfLoaded(void) {
  if (sCloudKitHooked) return;
  Class container = objc_getClass("CKContainer");
  if (!container) return;
  sCloudKitHooked = YES;
  if (LeadHasICloudEntitlement()) return;
  LeadSwizzle(container, NSSelectorFromString(@"_setupWithContainerID:options:"), (IMP)LeadCKSetup, NULL);
  LeadSwizzle(container, NSSelectorFromString(@"_initWithContainerIdentifier:"), (IMP)LeadCKInit, NULL);
}

#pragma mark -

static NSString *sLeadSideloadMode = @"off";

// One line for the diagnostics log: what the signature allows and where Telegram's
// group folder ended up (native / entitled:<group> / private / old-fixer).
NSString *LeadSideloadFixSummary(void) {
  NSString *keychain = [LeadEntitlement(@"keychain-access-groups") componentsJoinedByString:@","] ?: @"-";
  NSString *appId = LeadEntitlement(@"application-identifier") ?: @"-";
  NSMutableArray *resolved = [NSMutableArray array];
  NSMutableArray *extensions = [NSMutableArray array];
  os_unfair_lock_lock(&sResolvedLock);
  NSDictionary<NSString *, NSURL *> *snapshot = [sResolvedGroups copy];
  NSDictionary<NSString *, NSString *> *chosen = [sChosenGroups copy];
  os_unfair_lock_unlock(&sResolvedLock);
  for (NSString *entitled in LeadEntitledAppGroups()) {
    NSURL *root = sOrigContainerURL ? sOrigContainerURL([NSFileManager defaultManager], @selector(containerURLForSecurityApplicationGroupIdentifier:), entitled) : nil;
    NSString *folder = [root.path stringByAppendingPathComponent:@"Lead/_extensions"];
    for (NSString *name in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folder error:nil] ?: @[]) {
      NSString *note = [NSString stringWithContentsOfFile:[folder stringByAppendingPathComponent:name] encoding:NSUTF8StringEncoding error:nil];
      [extensions addObject:[NSString stringWithFormat:@"%@(%@)", name, note ?: @"?"]];
    }
  }
  [snapshot enumerateKeysAndObjectsUsingBlock:^(NSString *group, NSURL *url, __unused BOOL *stop) {
    NSString *kind = [url.path containsString:@"/Documents/AppGroup"] ? @"private" : [NSString stringWithFormat:@"shared:%@%@", chosen[group] ?: group, [url.path containsString:@"/Lead/"] ? @"/Lead/…" : @""];
    [resolved addObject:[NSString stringWithFormat:@"%@=%@", group, kind]];
    NSString *folder = [url.path stringByAppendingPathComponent:@"lead-extensions"];
    for (NSString *name in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folder error:nil] ?: @[]) {
      NSString *note = [NSString stringWithContentsOfFile:[folder stringByAppendingPathComponent:name] encoding:NSUTF8StringEncoding error:nil];
      [extensions addObject:[NSString stringWithFormat:@"%@(%@)", name, note ?: @"?"]];
    }
  }];
  return [NSString stringWithFormat:@"SIGN appId=%@ groups=[%@] keychain=[%@] icloud=%d fix=%@ resolved=[%@] extensionsSeen=[%@]",
      appId, [LeadEntitledAppGroups() componentsJoinedByString:@","], keychain, LeadHasICloudEntitlement(),
      sLeadSideloadMode, [resolved componentsJoinedByString:@","], [extensions componentsJoinedByString:@","]];
}

static BOOL LeadOldFixerLoaded(void) {
  uint32_t count = _dyld_image_count();
  for (uint32_t i = 0; i < count; i++) {
    const char *name = _dyld_get_image_name(i);
    if (name && strcasestr(name, "sideloadfixer")) return YES;
  }
  return NO;
}

__attribute__((constructor))
static void LeadSideloadFixInit(void) {
  @autoreleasepool {
    if (LeadOldFixerLoaded()) {
      NSLog(@"[Lead] SideloadFix: the old sideload fixer is loaded, leaving it in charge");
      sLeadSideloadMode = @"old-fixer";
      return;
    }
    sResolvedGroups = [NSMutableDictionary dictionary];
    sChosenGroups = [NSMutableDictionary dictionary];
    sLeadSideloadMode = @"lead";
    LeadSwizzle([NSFileManager class], @selector(containerURLForSecurityApplicationGroupIdentifier:),
                (IMP)LeadContainerURL, (IMP *)&sOrigContainerURL);
    // Telegram links CloudKit, so it's normally loaded before Lead; if not, look
    // again once the app is running (before anything gets to iCloud).
    LeadHookCloudKitIfLoaded();
    for (NSNumber *delay in @[ @0, @0.5, @2 ]) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay.doubleValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LeadHookCloudKitIfLoaded();
      });
    }
  }
}
