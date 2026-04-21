// roothide_stub.m
// Stub implementations of jbroot/rootfs for non-roothide (TrollStore/sideload) builds.
// All functions are identity operations — no path remapping needed.

#import <Foundation/Foundation.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

// C-string variants (cached — just return path as-is, no alloc needed for stubs)
const char* rootfs_alloc(const char* path) { return path ? strdup(path) : NULL; }
const char* jbroot_alloc(const char* path) { return path ? strdup(path) : NULL; }
const char* jbrootat_alloc(int fd, const char* path) { return path ? strdup(path) : NULL; }
unsigned long long jbrand(void) { return 0; }

// C-string cached variants declared in roothide.h
const char* jbroot(const char* path) { return path; }
const char* rootfs(const char* path) { return path; }

#ifdef __cplusplus
}
#endif

// ObjC overloadable variants — __attribute__((overloadable)) matches roothide.h
NSString* _Nonnull __attribute__((overloadable)) jbroot(NSString* _Nonnull path) { return path; }
NSString* _Nonnull __attribute__((overloadable)) rootfs(NSString* _Nonnull path) { return path; }
