#import "Headers.h"
#import <dlfcn.h>
#import <objc/runtime.h>

// Private interface to store our own strings dict (bypasses TGLocalization.get: quirks)
@interface LeadLocalization ()
@property (nonatomic, strong) NSDictionary *strings;
@end

@implementation LeadLocalization

+ (instancetype)shared {
	static LeadLocalization *instance;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		instance = [LeadLocalization new];
		[instance loadDefault];
	});
	return instance;
}

// Finds Lead.bundle using dladdr (works on both jailbroken AND sideloaded installs).
// dladdr gives us the exact path to our dylib, so we can find the bundle next to it
// regardless of where the app is installed.
- (NSString *)findBundlePath {
	Dl_info info;
	memset(&info, 0, sizeof(info));

	// Get address of a method we know is inside our own dylib
	IMP imp = class_getMethodImplementation(
		object_getClass([LeadLocalization class]),
		@selector(shared)
	);

	if (imp && dladdr((const void *)imp, &info) && info.dli_fname) {
		NSString *dylibPath = [NSString stringWithUTF8String:info.dli_fname];
		NSString *dylibDir  = [dylibPath stringByDeletingLastPathComponent];

		// 1. Next to the dylib (Frameworks/Lead.bundle)
		NSString *candidate = [dylibDir stringByAppendingPathComponent:@"Lead.bundle"];
		if ([[NSFileManager defaultManager] fileExistsAtPath:candidate]) return candidate;

		// 2. Parent directory (e.g. app bundle root)
		candidate = [[dylibDir stringByDeletingLastPathComponent]
		             stringByAppendingPathComponent:@"Lead.bundle"];
		if ([[NSFileManager defaultManager] fileExistsAtPath:candidate]) return candidate;

		// 3. Two levels up (some sideload structures)
		candidate = [[[dylibDir stringByDeletingLastPathComponent]
		                        stringByDeletingLastPathComponent]
		             stringByAppendingPathComponent:@"Lead.bundle"];
		if ([[NSFileManager defaultManager] fileExistsAtPath:candidate]) return candidate;
	}

	// 4. Classic jailbreak path via jbroot()
	NSString *jbPath = [NSString stringWithFormat:@"%@/Lead.bundle",
	                    jbroot(@"/Library/Application Support/Lead")];
	if ([[NSFileManager defaultManager] fileExistsAtPath:jbPath]) return jbPath;

	// 5. Last resort: main bundle resources (e.g. AltStore embed)
	return [[[NSBundle mainBundle] resourcePath]
	        stringByAppendingPathComponent:@"Lead.bundle"];
}

- (void)loadDefault {
	NSString *lang = [[NSUserDefaults standardUserDefaults]
	                  stringForKey:@"LeadLanguage"] ?: @"en";

	NSString *bundlePath = [self findBundlePath];

	NSString *stringsPath = [NSString stringWithFormat:@"%@/%@.lproj/Localizable.strings",
	                         bundlePath, lang];

	// Fall back to English if the selected language file doesn't exist
	if (![[NSFileManager defaultManager] fileExistsAtPath:stringsPath]) {
		stringsPath = [NSString stringWithFormat:@"%@/en.lproj/Localizable.strings",
		               bundlePath];
	}

	// Direct NSDictionary load — no dependency on TGLocalization.get: internals
	self.strings = [NSDictionary dictionaryWithContentsOfFile:stringsPath];

	// Also build the TGLocalization object (kept for any code that uses self.localization)
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

	// Direct dict lookup — always accurate, works even when TGLocalization.get: returns nil
	NSString *result = [LeadLocalization shared].strings[key];
	if (result) return result;

	// Fallback to TGLocalization (for languages loaded via that path)
	result = [[LeadLocalization shared].localization get:key];
	if (result && ![result isEqualToString:key]) return result;

	// Return the raw key so it's obvious something is missing (not silent garbage)
	return key;
}

@end
