// roothide_stub.m
// jbroot/rootfs for one Lead.dylib that runs everywhere: rootful, rootless,
// RootHide and sideload. The jailbreak root is derived from where this dylib was
// loaded from (…/Library/MobileSubstrate/DynamicLibraries or …/usr/lib/TweakInject):
// "" on rootful, /var/jb on rootless, the hidden .jbroot-XXXX folder on RootHide.
// Sideloaded (inside the app bundle) there is no jailbreak root and paths stay as is.

#import <Foundation/Foundation.h>
#include <dlfcn.h>
#include <string.h>

static NSString *LeadJailbreakRoot(void) {
  static NSString *root;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    root = @"";
    Dl_info info;
    if (!dladdr((const void *)&LeadJailbreakRoot, &info) || !info.dli_fname) return;
    NSString *image = [NSString stringWithUTF8String:info.dli_fname];
    for (NSString *marker in @[ @"/Library/MobileSubstrate/DynamicLibraries/", @"/usr/lib/TweakInject/" ]) {
      NSRange range = [image rangeOfString:marker];
      if (range.location != NSNotFound) {
        root = [image substringToIndex:range.location];
        return;
      }
    }
  });
  return root;
}

static NSString *LeadPrefixed(NSString *path) {
  NSString *root = LeadJailbreakRoot();
  if (root.length == 0 || ![path hasPrefix:@"/"] || [path hasPrefix:root]) return path;
  return [root stringByAppendingString:path];
}

static NSString *LeadUnprefixed(NSString *path) {
  NSString *root = LeadJailbreakRoot();
  if (root.length == 0 || ![path hasPrefix:root]) return path;
  NSString *rest = [path substringFromIndex:root.length];
  return rest.length ? rest : @"/";
}

#ifdef __cplusplus
extern "C" {
#endif

const char* rootfs_alloc(const char* path) { return path ? strdup(LeadUnprefixed(@(path)).fileSystemRepresentation) : NULL; }
const char* jbroot_alloc(const char* path) { return path ? strdup(LeadPrefixed(@(path)).fileSystemRepresentation) : NULL; }
const char* jbrootat_alloc(int fd, const char* path) { return jbroot_alloc(path); }
unsigned long long jbrand(void) { return 0; }

// The "cached" C variants promise strings that live as long as the process;
// Lead itself only uses the NSString ones, so a small leak per call is fine.
const char* jbroot(const char* path) { return jbroot_alloc(path); }
const char* rootfs(const char* path) { return rootfs_alloc(path); }

#ifdef __cplusplus
}
#endif

NSString* _Nonnull __attribute__((overloadable)) jbroot(NSString* _Nonnull path) { return LeadPrefixed(path); }
NSString* _Nonnull __attribute__((overloadable)) rootfs(NSString* _Nonnull path) { return LeadUnprefixed(path); }
