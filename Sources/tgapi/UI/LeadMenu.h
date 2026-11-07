#import <UIKit/UIKit.h>
#import "LeadDesign.h"

typedef NS_ENUM(NSInteger, LeadRowStyle) {
  LeadRowStyleToggle,      // bool NSUserDefaults key
  LeadRowStyleLink,        // opens something, chevron
  LeadRowStyleAction,      // runs something in place, no chevron
};

@interface LeadRow : NSObject
@property (nonatomic, assign) LeadRowStyle style;
@property (nonatomic, copy) NSString *defaultsKey;
@property (nonatomic, copy) NSString *titleKey;
@property (nonatomic, copy) NSString *subtitleKey;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, assign) BOOL destructive;
// Live trailing text (counts, coordinates, sizes). May be called often; keep it cheap.
@property (nonatomic, copy) NSString *(^valueBlock)(void);
@property (nonatomic, copy) void (^tapBlock)(UIViewController *host);
// Runs after a toggle row changes its setting.
@property (nonatomic, copy) void (^toggleBlock)(BOOL on, UIViewController *host);
+ (instancetype)toggle:(NSString *)key title:(NSString *)titleKey subtitle:(NSString *)subtitleKey symbol:(NSString *)symbol;
+ (instancetype)link:(NSString *)titleKey symbol:(NSString *)symbol tap:(void (^)(UIViewController *host))tap;
- (NSString *)title;
- (NSString *)subtitle;
- (BOOL)isOn;
@end

@interface LeadSection : NSObject
@property (nonatomic, copy) NSString *titleKey;
@property (nonatomic, copy) NSString *footerKey;
@property (nonatomic, copy) NSArray<LeadRow *> *rows;
// "All on / All off" switch for sections of toggles.
@property (nonatomic, assign) BOOL bulkToggle;
+ (instancetype)title:(NSString *)titleKey rows:(NSArray<LeadRow *> *)rows;
@end

@interface LeadPage : NSObject
@property (nonatomic, copy) NSString *titleKey;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSArray<LeadSection *> *sections;
@property (nonatomic, assign) BOOL isGhost;
- (NSArray<LeadRow *> *)toggleRows;
- (NSInteger)enabledCount;
@end

#ifdef __cplusplus
extern "C" {
#endif
LeadPage *LeadGhostPage(void);
// Every page reachable from the home screen's Features section, in order.
NSArray<LeadPage *> *LeadFeaturePages(void);
NSArray<NSString *> *LeadGhostFeatureKeys(void);
NSInteger LeadEnabledFeatureCount(void);
// Ghost Mode needs at least one sub-option; turning it on with none picks sensible ones.
BOOL LeadEnableGhostMode(UIViewController *host);
NSString *LeadGhostStatusText(void);
UIImage *LeadLogoImage(CGFloat side);
void LeadOpenTelegramURL(NSString *urlString);
NSArray<NSDictionary *> *LeadMessageLogEntries(void);
NSString *LeadURLForLogEntry(NSDictionary *entry);
NSString *LeadProfileChangeText(NSDictionary *entry);
// "≈ 2019" for a user id, from known id/date anchors; nil for non-users.
NSString *LeadRegistrationEstimate(long long userId);

// Settings transfer through the clipboard (JSON).
void LeadExportSettings(UIViewController *host);
void LeadImportSettings(UIViewController *host);
// Reads the account's real 18+ setting into the switch, quietly.
void LeadRefreshContentSettings(void);
// Defined in Hooks.xm: MtProtoKit requests seen so far, and seconds since Lead loaded.
// No traffic a while after launch means Telegram runs its Rust engine.
long long LeadNetworkHookActivity(void);
// Versions and key switches, written at the top of a shared diagnostics log.
NSString *LeadDiagStateLine(void);
NSString *LeadDiagSignLine(void);
double LeadTweakUptime(void);
// Lead in the notification service extension's binary: 1 yes, 0 no, -1 no such extension.
NSInteger LeadExtensionInjected(void);
#ifdef __cplusplus
}
#endif

// What of Lead works with this client, checked live.
@interface LeadCompatViewController : UITableViewController
@end

// A page of LeadSections (Messages, Content, Ghost Mode, …).
@interface LeadPageViewController : UITableViewController
- (instancetype)initWithPage:(LeadPage *)page;
@end

@interface LeadGhostExceptionsViewController : UITableViewController
@end

// In-app banner for deletions caught by Anti-Revoke (kDeletionBanner).
@interface LeadDeletionBanner : NSObject
+ (void)install;
@end

// Versions of one edited message, opened from the pencil next to it.
@interface LeadEditHistoryViewController : UIViewController
// key comes from +[TLParser editKeyForNode:].
+ (void)presentForKey:(NSString *)key mediaReplaced:(BOOL)mediaReplaced from:(UIViewController *)host;
@end

// Deleted / edited messages recorded by Anti-Revoke and Anti-Edit.
@interface LeadMessageLogViewController : UITableViewController
@end
