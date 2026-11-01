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

// An install that ran with the old fixer keeps its account in <Documents>/AppGroup.
// Once a real, shared container is available, move it there (once, before Telegram
// opens anything) so the user stays logged in and the extension can read it.
static void LeadMigratePrivateFolderIfNeeded(NSURL *container) {
  if (LeadIsAppExtension()) return;
  NSFileManager *fm = [NSFileManager defaultManager];
  NSURL *documents = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
  NSURL *legacy = [documents URLByAppendingPathComponent:@"AppGroup" isDirectory:YES];
  NSString *legacyData = [legacy.path stringByAppendingPathComponent:@"telegram-data"];
  NSString *targetData = [container.path stringByAppendingPathComponent:@"telegram-data"];
  if (![fm fileExistsAtPath:legacyData] || [fm fileExistsAtPath:targetData]) return;
  NSArray<NSString *> *items = [fm contentsOfDirectoryAtPath:legacy.path error:nil] ?: @[];
  for (NSString *item in items) {
    NSString *from = [legacy.path stringByAppendingPathComponent:item];
    NSString *to = [container.path stringByAppendingPathComponent:item];
    if ([fm fileExistsAtPath:to]) continue;
    NSError *error = nil;
    if (![fm moveItemAtPath:from toPath:to error:&error]) {
      NSLog(@"[Lead] SideloadFix: moving %@ failed: %@", item, error);
    }
  }
  NSLog(@"[Lead] SideloadFix: moved the old fixer's data into %@", container.path);
}

// Extensions leave a note in the shared folder, so the app's diagnostics can tell
// that Lead ran inside them and which group they landed in.
static void LeadMarkExtension(NSURL *container, NSString *group) {
  if (!LeadIsAppExtension()) return;
  NSString *folder = [container.path stringByAppendingPathComponent:@"lead-extensions"];
  [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
  NSString *name = [NSBundle mainBundle].bundlePath.lastPathComponent ?: @"extension";
  NSString *note = [NSString stringWithFormat:@"%.0f %@", [NSDate date].timeIntervalSince1970, group];
  [note writeToFile:[folder stringByAppendingPathComponent:name] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

static NSURL *LeadResolveContainer(id self, SEL _cmd, NSString *group) {
  NSURL *url = sOrigContainerURL(self, _cmd, group);
  if (url) {
    LeadMigratePrivateFolderIfNeeded(url);
    LeadMarkExtension(url, group);
    return url;
  }
  // The app and each extension resolve this on their own, and their entitlements
  // may list the groups in different orders. Pick the same one everywhere: the
  // group that already holds Telegram's data, else the first by name.
  NSMutableArray<NSString *> *candidates = [NSMutableArray array];
  NSMutableDictionary<NSString *, NSURL *> *urls = [NSMutableDictionary dictionary];
  for (NSString *entitled in [LeadEntitledAppGroups() sortedArrayUsingSelector:@selector(compare:)]) {
    if ([entitled isEqualToString:group]) continue;
    NSURL *candidate = sOrigContainerURL(self, _cmd, entitled);
    if (!candidate) continue;
    [candidates addObject:entitled];
    urls[entitled] = candidate;
  }
  NSString *chosen = candidates.firstObject;
  for (NSString *entitled in candidates) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[urls[entitled].path stringByAppendingPathComponent:@"telegram-data"]]) {
      chosen = entitled;
      break;
    }
  }
  if (chosen) {
    url = urls[chosen];
    NSLog(@"[Lead] SideloadFix: %@ → entitled group %@", group, chosen);
    os_unfair_lock_lock(&sResolvedLock);
    sChosenGroups[group] = chosen;
    os_unfair_lock_unlock(&sResolvedLock);
    LeadMigratePrivateFolderIfNeeded(url);
    LeadMarkExtension(url, chosen);
    return url;
  }
  NSLog(@"[Lead] SideloadFix: %@ → private folder (no app group in the signature)", group);
  return LeadPrivateGroupFolder();
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
  [snapshot enumerateKeysAndObjectsUsingBlock:^(NSString *group, NSURL *url, __unused BOOL *stop) {
    NSString *kind = [url.path containsString:@"/Documents/AppGroup"] ? @"private" : [NSString stringWithFormat:@"shared:%@", chosen[group] ?: group];
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
