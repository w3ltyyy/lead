#import "Headers.h"
#import <dlfcn.h>
#import <objc/runtime.h>

// ============================================================
// LeadBundlePath() — shared function used by LeadLocalization
// and LanguageSelector to find Lead.bundle.
//
// Search order:
//  1. Next to the dylib via dladdr (covers Frameworks/ layout)
//  2. Parent of dylib directory (app bundle root)
//  3. Two levels up (some nested layouts)
//  4. Classic jailbreak path via jbroot()
//  5. NSBundle.mainBundle.bundlePath (IPA embed)
//  6. NSBundle.mainBundle.resourcePath (fallback)
// ============================================================
NSString *LeadBundlePath(void) {
    static NSString *cachedPath = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSFileManager *fm = [NSFileManager defaultManager];

        // 1–3: Use dladdr to find the dylib, then search near it
        Dl_info info;
        memset(&info, 0, sizeof(info));
        // Use a known symbol inside this dylib
        IMP imp = class_getMethodImplementation(
            object_getClass([LeadLocalization class]),
            @selector(shared)
        );
        if (imp && dladdr((const void *)imp, &info) && info.dli_fname) {
            NSString *dylibPath = [NSString stringWithUTF8String:info.dli_fname];
            NSString *dylibDir  = [dylibPath stringByDeletingLastPathComponent];

            NSArray *candidates = @[
                [dylibDir stringByAppendingPathComponent:@"Lead.bundle"],
                [[dylibDir stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Lead.bundle"],
                [[[dylibDir stringByDeletingLastPathComponent] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Lead.bundle"],
            ];

            for (NSString *c in candidates) {
                if ([fm fileExistsAtPath:c]) { cachedPath = c; return; }
            }
        }

        // 4: Classic jailbreak path
        NSString *jbPath = [NSString stringWithFormat:@"%@/Lead.bundle",
                            jbroot(@"/Library/Application Support/Lead")];
        if ([fm fileExistsAtPath:jbPath]) { cachedPath = jbPath; return; }

        // 5: IPA embed — app bundle root
        NSString *appPath = [[NSBundle mainBundle].bundlePath
                             stringByAppendingPathComponent:@"Lead.bundle"];
        if ([fm fileExistsAtPath:appPath]) { cachedPath = appPath; return; }

        // 6: resourcePath fallback
        cachedPath = [[[NSBundle mainBundle] resourcePath]
                      stringByAppendingPathComponent:@"Lead.bundle"];
    });
    return cachedPath;
}

// Private interface to store our own strings dict
@interface LeadLocalization ()
@property (nonatomic, strong) NSDictionary *strings;
@end

@implementation LeadLocalization

+ (instancetype)shared {
    static LeadLocalization *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [LeadLocalization new];
        [instance loadDefault];
    });
    return instance;
}

- (void)loadDefault {
    NSString *lang = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"LeadLanguage"] ?: @"en";

    NSString *bundlePath = LeadBundlePath();
    NSString *stringsPath = [NSString stringWithFormat:@"%@/%@.lproj/Localizable.strings",
                             bundlePath, lang];

    // Fall back to English if selected language file is missing
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringsPath]) {
        stringsPath = [NSString stringWithFormat:@"%@/en.lproj/Localizable.strings",
                       bundlePath];
    }

    // Direct NSDictionary load — no dependency on TGLocalization internals
    self.strings = [NSDictionary dictionaryWithContentsOfFile:stringsPath];

    // Also build the TGLocalization object (kept for code that uses self.localization)
    if (self.strings) {
        self.localization = [[objc_getClass("TGLocalization") alloc]
                             initWithVersion:96929692
                                        code:lang
                                        dict:self.strings
                                    isActive:YES];
    }
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    if (!key) return nil;

    // Direct dict lookup — always accurate
    NSString *result = [LeadLocalization shared].strings[key];
    if (result) return result;

    // Fallback to TGLocalization
    result = [[LeadLocalization shared].localization get:key];
    if (result && ![result isEqualToString:key]) return result;

    return key;
}

@end
