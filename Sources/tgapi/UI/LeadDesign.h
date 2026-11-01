#import <UIKit/UIKit.h>

// Lead menu design system. Monochrome like the logo: ink (label color) on
// grouped backgrounds, one functional green for switches, no decoration that
// doesn't carry information. Everything works back to iOS 14.

#define LeadL(key) [LeadLocalization localizedStringForKey:(key)]

extern NSString *const kLeadTweakVersion;
extern NSString *const kLeadTweakBuild;
// Posted whenever a Lead setting changes from the menu.
extern NSString *const LeadSettingsDidChangeNotification;

#ifdef __cplusplus
extern "C" {
#endif
UIFont *LeadFont(CGFloat size, UIFontWeight weight);
UIFont *LeadRoundedFont(CGFloat size, UIFontWeight weight);
void LeadSelectionHaptic(void);
void LeadImpactHaptic(UIImpactFeedbackStyle style);
void LeadSpring(NSTimeInterval duration, CGFloat damping, void (^animations)(void), void (^completion)(BOOL finished));
// Flips a Lead bool setting, posts LeadSettingsDidChangeNotification and arms the restart pill.
void LeadSetBool(NSString *key, BOOL value);
// Same notification + restart pill for changes that aren't a single bool (import, amounts).
void LeadNotifySettingsChanged(void);
BOOL LeadNeedsRestart(void);
void LeadRestartTelegram(void);
// Telegram's main window. -[UIApplication keyWindow] can be nil (after a system
// sheet, a call, the keyboard) and Telegram never makes a window key again.
UIWindow *LeadMainWindow(void);
// Topmost controller of the main window that can present something now.
UIViewController *LeadTopPresenter(void);
#ifdef __cplusplus
}
#endif

// The Lead mark (rounded right triangle) drawn as a vector so it follows the
// appearance and can be animated.
@interface LeadLogoView : UIView
- (void)playIntro;
@end

// Square icon tile. Outline style when off, filled ink when the feature is on.
@interface LeadIconTile : UIView
@property (nonatomic, assign) CGFloat side;
- (void)setSymbol:(NSString *)symbol;
- (void)setText:(NSString *)text;
- (void)setImage:(UIImage *)image;
// A monochrome logo, tinted like an SF Symbol.
- (void)setTemplateImage:(UIImage *)image;
- (void)setActive:(BOOL)active animated:(BOOL)animated;
@end

// Row cell: icon tile, title, optional subtitle, and a switch, value or chevron.
@interface LeadCell : UITableViewCell
@property (nonatomic, strong, readonly) LeadIconTile *tile;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subtitleLabel;
@property (nonatomic, strong, readonly) UILabel *valueLabel;
@property (nonatomic, strong, readonly) UISwitch *toggle;
@property (nonatomic, copy) void (^onToggle)(BOOL on);
- (void)configureTitle:(NSString *)title subtitle:(NSString *)subtitle symbol:(NSString *)symbol;
- (void)showToggle:(BOOL)on;
- (void)showValue:(NSString *)value chevron:(BOOL)chevron;
- (void)setDestructive:(BOOL)destructive;
@end

// Large Ghost Mode card used on the home screen and the Ghost page.
@interface LeadHeroCell : UITableViewCell
@property (nonatomic, strong, readonly) UISwitch *toggle;
@property (nonatomic, copy) void (^onToggle)(BOOL on);
- (void)configureTitle:(NSString *)title status:(NSString *)status on:(BOOL)on animated:(BOOL)animated;
@end

// Section header with an optional trailing text button.
@interface LeadSectionHeader : UITableViewHeaderFooterView
@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) UIButton *actionButton;
@property (nonatomic, copy) void (^onAction)(void);
@end

// Short-lived capsule message at the top of a view.
@interface LeadToast : NSObject
+ (void)showText:(NSString *)text symbol:(NSString *)symbol inView:(UIView *)view;
@end

// Navigation controller for the whole menu; owns the floating restart pill.
@interface LeadNavigationController : UINavigationController
@end

// Plain scrolling text page (disclaimer, debug log).
@interface LeadTextViewController : UIViewController
- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text monospaced:(BOOL)monospaced;
@property (nonatomic, copy) NSString *filePath; // when set: Copy / Clear actions for a log file
@end

// Fades and lifts rows in, staggered, the first time a list appears.
void LeadAnimateCellIn(UITableViewCell *cell, NSInteger order);
