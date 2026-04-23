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

        // 1. Try to find the bundle using NSBundle's built-in methods (most reliable for IPAs)
        for (NSBundle *bundle in [NSBundle allBundles]) {
            if ([bundle.bundlePath hasSuffix:@"Lead.bundle"] || [bundle.bundlePath hasSuffix:@"Choco.bundle"]) {
                cachedPath = bundle.bundlePath;
                return;
            }
            NSString *jsonPath = [bundle pathForResource:@"langs" ofType:@"json"];
            if (jsonPath) {
                cachedPath = [jsonPath stringByDeletingLastPathComponent];
                return;
            }
        }
        
        for (NSBundle *bundle in [NSBundle allFrameworks]) {
             NSString *jsonPath = [bundle pathForResource:@"langs" ofType:@"json"];
             if (jsonPath) {
                 cachedPath = [jsonPath stringByDeletingLastPathComponent];
                 return;
             }
        }

        // 2. Fallback to dylib-relative path (dladdr)
        Dl_info info;
        memset(&info, 0, sizeof(info));
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
                [dylibDir stringByAppendingPathComponent:@"Choco.bundle"],
                [[dylibDir stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Choco.bundle"]
            ];

            for (NSString *c in candidates) {
                if ([fm fileExistsAtPath:c]) { cachedPath = c; return; }
            }
        }

        // 3. Classic jailbreak path
        NSString *jbPath = [NSString stringWithFormat:@"%@/Lead.bundle",
                            jbroot(@"/Library/Application Support/Lead")];
        if ([fm fileExistsAtPath:jbPath]) { cachedPath = jbPath; return; }

        // 4. Final desperate scan in the main bundle's subdirectories
        NSString *bundlePath = [NSBundle mainBundle].bundlePath;
        NSArray *subDirs = @[@"Lead.bundle", @"Choco.bundle", @"Frameworks/Lead.bundle", @"Frameworks/Choco.bundle"];
        for (NSString *sub in subDirs) {
            NSString *path = [bundlePath stringByAppendingPathComponent:sub];
            if ([fm fileExistsAtPath:path]) { cachedPath = path; return; }
        }
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

    // 1. Direct dict lookup from loaded bundle file — always most accurate
    NSString *result = [LeadLocalization shared].strings[key];
    if (result) return result;

    // 2. Fallback to TGLocalization wrapper
    result = [[LeadLocalization shared].localization get:key];
    if (result && ![result isEqualToString:key]) return result;

    // 3. Hardcoded English fallback — guarantees readable UI even without a bundle
    static NSDictionary *sBuiltinEnglish = nil;
    static dispatch_once_t sOnce;
    dispatch_once(&sOnce, ^{
        sBuiltinEnglish = @{
            /* Sections */
            @"GHOST_MODE_SECTION_HEADER"              : @"Ghost Mode",
            @"READ_RECEIPT_SECTION_HEADER"            : @"Read Receipts",
            @"MISC_SECTION_HEADER"                    : @"Privacy & Extras",
            @"FILE_FIXER_SECTION_HEADER"              : @"File Picker Fix",
            @"FAKE_LOCATION_SECTION_HEADER"           : @"Fake Location",
            @"LANGUAGE_SECTION_HEADER"                : @"Language",
            @"CREDITS_SECTION_HEADER"                 : @"Credits",
            /* Ghost Mode */
            @"DISABLE_ONLINE_STATUS_TITLE"            : @"Hide Online Status",
            @"DISABLE_ONLINE_STATUS_SUBTITLE"         : @"Prevent others from seeing when you are online.",
            @"DISABLE_TYPING_STATUS_TITLE"            : @"Hide Typing Status",
            @"DISABLE_TYPING_STATUS_SUBTITLE"         : @"Hide the 'typing…' indicator when composing a message.",
            @"DISABLE_RECORDING_VIDEO_STATUS_TITLE"   : @"Hide Recording Video Status",
            @"DISABLE_RECORDING_VIDEO_STATUS_SUBTITLE": @"Hide the indicator when recording a video.",
            @"DISABLE_UPLOADING_VIDEO_STATUS_TITLE"   : @"Hide Uploading Video Status",
            @"DISABLE_UPLOADING_VIDEO_STATUS_SUBTITLE": @"Hide the indicator when uploading a video.",
            @"DISABLE_VC_MESSAGE_RECORDING_STATUS_TITLE"   : @"Hide Voice Recording Status",
            @"DISABLE_VC_MESSAGE_RECORDING_STATUS_SUBTITLE": @"Hide the indicator when recording a voice message.",
            @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_TITLE"   : @"Hide Voice Uploading Status",
            @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_SUBTITLE": @"Hide the indicator when uploading a voice message.",
            @"DISABLE_UPLOADING_PHOTO_STATUS_TITLE"   : @"Hide Uploading Photo Status",
            @"DISABLE_UPLOADING_PHOTO_STATUS_SUBTITLE": @"Hide the indicator when uploading a photo.",
            @"DISABLE_UPLOADING_FILE_STATUS_TITLE"    : @"Hide Uploading File Status",
            @"DISABLE_UPLOADING_FILE_STATUS_SUBTITLE" : @"Hide the indicator when uploading a file.",
            @"DISABLE_CHOOSING_LOCATION_STATUS_TITLE"   : @"Hide Choosing Location Status",
            @"DISABLE_CHOOSING_LOCATION_STATUS_SUBTITLE": @"Hide the indicator when choosing a location to share.",
            @"DISABLE_CHOOSING_CONTACT_TITLE"         : @"Hide Choosing Contact Status",
            @"DISABLE_CHOOSING_CONTACT_SUBTITLE"      : @"Hide the indicator when selecting a contact to share.",
            @"DISABLE_PLAYING_GAME_STATUS_TITLE"      : @"Hide Playing Game Status",
            @"DISABLE_PLAYING_GAME_STATUS_SUBTITLE"   : @"Hide the indicator when playing an inline game.",
            @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_TITLE"   : @"Hide Recording Round Video Status",
            @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_SUBTITLE": @"Hide the indicator when recording a round video message.",
            @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_TITLE"   : @"Hide Uploading Round Video Status",
            @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_SUBTITLE": @"Hide the indicator when uploading a round video message.",
            @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_TITLE"   : @"Hide Speaking in Group Call Status",
            @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_SUBTITLE": @"Hide the indicator when speaking in a group call.",
            @"DISABLE_CHOOSING_STICKER_STATUS_TITLE"   : @"Hide Choosing Sticker Status",
            @"DISABLE_CHOOSING_STICKER_STATUS_SUBTITLE": @"Hide the indicator when picking a sticker.",
            @"DISABLE_EMOJI_INTERACTION_STATUS_TITLE"   : @"Hide Emoji Interaction Status",
            @"DISABLE_EMOJI_INTERACTION_STATUS_SUBTITLE": @"Hide the indicator when interacting with emoji.",
            @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_TITLE"   : @"Hide Emoji Reaction Status",
            @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_SUBTITLE": @"Hide the indicator when reacting with emoji to a message.",
            /* Read Receipts */
            @"READ_RECEIPTS"                          : @"Read Receipts",
            @"DISABLE_MESSAGE_READ_RECEIPT_TITLE"     : @"Disable Message Read Receipts",
            @"DISABLE_MESSAGE_READ_RECEIPT_SUBTITLE"  : @"Others won't see that you've read their messages.",
            @"DISABLE_STORY_READ_RECEIPT_TITLE"       : @"Disable Story View Receipts",
            @"DISABLE_STORY_READ_RECEIPT_SUBTITLE"    : @"Others won't see that you've viewed their stories.",
            /* Privacy & Extras */
            @"MISC"                                   : @"Privacy & Extras",
            @"DISABLE_ALL_ADS_TITLE"                  : @"Disable All Ads",
            @"DISABLE_ALL_ADS_SUBTITLE"               : @"Remove sponsored messages and promotional content from the app.",
            @"ENABLE_SAVING_PROTECTED_CONTENT_TITLE"  : @"Save Restricted Media",
            @"ENABLE_SAVING_PROTECTED_CONTENT_SUBTITLE": @"Bypass forwarding restrictions — save and forward media from protected chats and channels.",
            @"ANTI_REVOKE_TITLE"                      : @"Save Deleted Messages",
            @"ANTI_REVOKE_SUBTITLE"                   : @"Keep messages in your chat even after the sender deletes them. Deleted messages stay visible to you.",
            @"ANTI_EDIT_TITLE"                        : @"Save Original Edited Messages",
            @"ANTI_EDIT_SUBTITLE"                     : @"When someone edits a message, the original text is preserved on your end. You'll always see what was first written.",
            @"ANTI_SCREENSHOT_TITLE"                  : @"Disable Screenshot Notifications",
            @"ANTI_SCREENSHOT_SUBTITLE"               : @"Take screenshots in secret chats and protected channels without sending a notification to the other person.",
            @"ANTI_SELF_DESTRUCT_TITLE"               : @"View Disappearing Media Freely",
            @"ANTI_SELF_DESTRUCT_SUBTITLE"            : @"Open one-time and disappearing photos/videos without triggering the self-destruct timer. The media stays visible locally.",
            /* File Picker */
            @"FIX_FILE_PICKER_TITLE"                  : @"Fix File Picker",
            @"FIX_FILE_PICKER_SUBTITLE"               : @"Fixes the issue where you can't pick files from the Files app on sideloaded versions.",
            @"CLEAR_FILE_PICKER_CACHE_TITLE"          : @"Clear File Picker Cache",
            @"CLEAR_FILE_PICKER_CACHE_SUBTITLE"       : @"File Picker copies files to a temp directory. Tap here to clear that cache and free up storage.",
            @"CACHE_CLEAR_WARNING_TITLE"              : @"Confirm",
            @"CACHE_CLEAR_WARNING_MESSAGE"            : @"Are you sure you want to clear the file picker cache?",
            /* Fake Location */
            @"ENABLE_FAKE_LOCATION_TITLE"             : @"Enable Location Spoofing",
            @"ENABLE_FAKE_LOCATION_SUBTITLE"          : @"Override your device's GPS and share a custom location instead.",
            @"SELECT_FAKE_LOCATION_TITLE"             : @"Select Fake Location",
            /* Common */
            @"APPLY"                                  : @"Apply",
            @"APPLY_CHANGES"                          : @"The app will close and restart to apply your changes. Continue?",
            @"OK"                                     : @"OK",
            @"CANCEL"                                 : @"Cancel",
            @"DISCLAIMER"                             : @"Disclaimer",
            @"AUTHOR_MESSAGE"                         : @"This Telegram tweak is for personal and educational use only. We are not affiliated with Telegram in any way. All trademarks, including the Telegram name and logo, belong to their respective owners. Don't use this to break rules or violate Telegram's terms — we're not responsible if things go sideways. Use at your own risk.\n\nAlso… if you like it, say something. I seriously live off validation.\n\nIf you want to support the project, feel free to reach out on Telegram.",
        };
    });

    result = sBuiltinEnglish[key];
    return result ?: key;
}

@end
