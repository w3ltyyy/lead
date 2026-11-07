#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Headers.h"
#import "../Logger/Logger.h"
#import "LeadMenu.h"
#import "../Headers.h"
#import <objc/runtime.h>
#import <os/lock.h>
#import <objc/message.h>

@interface ASDisplayNode : NSObject
@property (atomic, strong, readonly) CALayer *layer;
@property (atomic, assign, readonly) UIView *view;
@property (atomic, copy, readonly) NSArray *subnodes;
@property (atomic, copy, readwrite) NSString *accessibilityLabel;
@property (nonatomic, strong) UILongPressGestureRecognizer *leadLongPressGesture;
- (ASDisplayNode *)supernode;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
@end

@interface ASControlNode : ASDisplayNode
- (void)sendActionsForControlEvents:(NSUInteger)controlEvents withEvent:(UIEvent *)event;
@end

@interface _TtC18MultiScaleTextNode18MultiScaleTextNode : ASDisplayNode
@end


@interface _TtC14PeerInfoScreen18PeerInfoHeaderNode : ASDisplayNode
@property (nonatomic, strong) id peer;
@end

@interface TGMediaVideoConverter : NSObject
+ (id)hashForAVAsset:(AVAsset *)avAsset adjustments:(id)adjustments;
@end

@interface TGVideoEditAdjustments : NSObject
+ (instancetype)editAdjustmentsWithDictionary:(NSDictionary *)dictionary;
- (NSTimeInterval)trimStartValue;
- (NSTimeInterval)trimEndValue;
@end

@interface LegacyComponentsGlobals : NSObject
+ (id)provider;
@end

@protocol LegacyComponentsGlobalsProvider
- (TGLocalization *)effectiveLocalization;
@end

static TGLocalization *TGLocalizationShared = nil;

static TGLocalization *getActiveTGLocalization(void) {
    if (TGLocalizationShared) return TGLocalizationShared;
    @try {
        Class cls = objc_getClass("LegacyComponentsGlobals");
        if (cls && [cls respondsToSelector:@selector(provider)]) {
            id provider = [cls performSelector:@selector(provider)];
            if ([provider respondsToSelector:@selector(effectiveLocalization)]) {
                TGLocalization *loc = [provider performSelector:@selector(effectiveLocalization)];
                if (loc) { TGLocalizationShared = loc; return loc; }
            }
        }
    } @catch (...) {}
    return nil;
}

void showUI();
static BOOL LeadIsUsableGhostTitle(NSString *title);
static BOOL LeadIsCurrentUserPeer(long long peerId);
static long long LeadPeerIdFromObject(id object);
static char LeadEditHistoryTapGestureKey;
static char LeadVideoToVoiceButtonKey;

static UIViewController *LeadTopViewController(void) {
    UIViewController *root = LeadTopPresenter();
    if ([root isKindOfClass:[UINavigationController class]]) {
        root = ((UINavigationController *)root).visibleViewController;
    } else if ([root isKindOfClass:[UITabBarController class]]) {
        root = ((UITabBarController *)root).selectedViewController;
        if ([root isKindOfClass:[UINavigationController class]]) {
            root = ((UINavigationController *)root).visibleViewController;
        }
    }
    return root;
}

// Little round badge next to a message bubble: trash (deleted), pencil (edited),
// timer (self-destructing). Lives on the item node's view under tag 8898.
typedef NS_ENUM(NSInteger, LeadBadgeKind) {
    LeadBadgeKindNone,
    LeadBadgeKindDeleted,
    LeadBadgeKindEdited,
    LeadBadgeKindTimer,
};

static const CGFloat LeadBadgeSide = 22.0;

@interface LeadMessageBadge : UIView
@property (nonatomic, assign) LeadBadgeKind kind;
@property (nonatomic, assign) BOOL alsoEdited;
@property (nonatomic, copy) NSString *editKey;
@property (nonatomic, copy) NSString *peerTag;
@property (nonatomic, strong) NSNumber *messageId;
// Which side of the bubble it sits on, once known: -1 left of it (outgoing), 1 right
// of it (incoming). A message never changes sides, so this outlives the layout
// passes where Telegram rebuilds the bubble with an empty frame (adding a reaction).
@property (nonatomic, assign) NSInteger side;
// A deleted message that was also edited gets a second, pencil badge right under
// the trash one: each badge opens its own thing.
@property (nonatomic, assign) BOOL isSecondary;
@property (nonatomic, weak) LeadMessageBadge *companion;
- (void)setKind:(LeadBadgeKind)kind animated:(BOOL)animated;
@end

@implementation LeadMessageBadge {
    UIVisualEffectView *_blur;
    UIImageView *_glyph;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 8898;
        self.userInteractionEnabled = NO;
        _blur = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterial]];
        _blur.frame = self.bounds;
        _blur.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _blur.layer.cornerRadius = LeadBadgeSide / 2.0;
        _blur.clipsToBounds = YES;
        [self addSubview:_blur];
        _glyph = [UIImageView new];
        _glyph.contentMode = UIViewContentModeCenter;
        _glyph.frame = self.bounds;
        _glyph.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_glyph];
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOpacity = 0.12;
        self.layer.shadowRadius = 3;
        self.layer.shadowOffset = CGSizeMake(0, 1);
    }
    return self;
}

- (void)setKind:(LeadBadgeKind)kind {
    [self setKind:kind animated:NO];
}

- (void)setKind:(LeadBadgeKind)kind animated:(BOOL)animated {
    BOOL changed = _kind != kind;
    _kind = kind;
    NSString *symbol = nil;
    UIColor *tint = nil;
    switch (kind) {
    case LeadBadgeKindDeleted:
        symbol = @"trash.fill";
        tint = UIColor.systemRedColor;
        break;
    case LeadBadgeKindEdited:
        symbol = @"pencil";
        tint = UIColor.labelColor;
        break;
    case LeadBadgeKindTimer:
        symbol = @"timer";
        tint = UIColor.systemOrangeColor;
        break;
    case LeadBadgeKindNone:
        break;
    }
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:10.5 weight:UIImageSymbolWeightBold];
    _glyph.image = symbol ? [UIImage systemImageNamed:symbol withConfiguration:config] : nil;
    _glyph.tintColor = tint;
    self.accessibilityLabel = kind == LeadBadgeKindDeleted ? LeadL(@"UI_DELETED_MARK") : kind == LeadBadgeKindEdited ? LeadL(@"UI_EDIT_HISTORY_TITLE") : nil;
    if (animated && changed) {
        self.transform = CGAffineTransformMakeScale(0.4, 0.4);
        self.alpha = 0;
        [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.62 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1;
        } completion:nil];
    }
}
@end

static LeadMessageBadge *LeadBadgeInView(UIView *view) {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[LeadMessageBadge class]] && !((LeadMessageBadge *)subview).isSecondary) return (LeadMessageBadge *)subview;
    }
    return nil;
}

static LeadMessageBadge *LeadSecondaryBadgeInView(UIView *view) {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[LeadMessageBadge class]] && ((LeadMessageBadge *)subview).isSecondary) return (LeadMessageBadge *)subview;
    }
    return nil;
}

static NSString *LeadDeletionTimeText(NSString *peerTag, NSNumber *messageId) {
    if (!messageId) return nil;
    for (NSDictionary *entry in LeadMessageLogEntries()) {
        if (![entry[@"kind"] isEqual:@"deleted"] || [entry[@"id"] intValue] != messageId.intValue) continue;
        if (peerTag.length && entry[@"peer"] && ![entry[@"peer"] isEqual:peerTag]) continue;
        NSNumber *timestamp = entry[@"date"];
        if (![timestamp isKindOfClass:[NSNumber class]]) return nil;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
        // With seconds: deletions often come in bursts, and that's how to tell them apart.
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.timeStyle = NSDateFormatterMediumStyle;
        formatter.dateStyle = [NSCalendar.currentCalendar isDateInToday:date] ? NSDateFormatterNoStyle : NSDateFormatterMediumStyle;
        formatter.doesRelativeDateFormatting = YES;
        return [formatter stringFromDate:date];
    }
    return nil;
}

static void LeadBadgeTapped(LeadMessageBadge *badge) {
    UIViewController *host = LeadTopViewController();
    if (!host) return;
    if (badge.kind == LeadBadgeKindEdited) {
        BOOL hasText = badge.editKey.length && [TLParser editHistoryForKey:badge.editKey].count > 0;
        [LeadEditHistoryViewController presentForKey:badge.editKey mediaReplaced:!hasText from:host];
    } else if (badge.kind == LeadBadgeKindDeleted) {
        NSString *time = LeadDeletionTimeText(badge.peerTag, badge.messageId);
        NSString *text = time ? [NSString stringWithFormat:LeadL(@"UI_DELETED_MARK_AT"), time] : LeadL(@"UI_DELETED_MARK");
        LeadSelectionHaptic();
        [LeadToast showText:text symbol:@"trash" inView:host.view];
    }
}

// Telegram's list routes touches through its own recognizers, so the badge
// can't take a tap itself; one recognizer on the item view checks the badge frame.
@interface LeadBadgeTapTarget : NSObject <UIGestureRecognizerDelegate>
+ (instancetype)shared;
@end

@implementation LeadBadgeTapTarget
+ (instancetype)shared {
    static LeadBadgeTapTarget *target = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        target = [LeadBadgeTapTarget new];
    });
    return target;
}

static BOOL LeadBadgeHit(UIGestureRecognizer *recognizer, LeadMessageBadge **outBadge) {
    CGPoint location = [recognizer locationInView:recognizer.view];
    LeadMessageBadge *best = nil;
    CGFloat bestDistance = CGFLOAT_MAX;
    // Of the badges whose (enlarged) frame holds the touch, the nearest one wins.
    for (LeadMessageBadge *badge in @[ LeadBadgeInView(recognizer.view) ?: (id)[NSNull null], LeadSecondaryBadgeInView(recognizer.view) ?: (id)[NSNull null] ]) {
        if (![badge isKindOfClass:[LeadMessageBadge class]]) continue;
        if (badge.hidden || badge.alpha < 0.01 || badge.kind == LeadBadgeKindNone || badge.kind == LeadBadgeKindTimer) continue;
        if (!CGRectContainsPoint(CGRectInset(badge.frame, -12, -12), location)) continue;
        CGFloat distance = hypot(location.x - CGRectGetMidX(badge.frame), location.y - CGRectGetMidY(badge.frame));
        if (distance < bestDistance) {
            bestDistance = distance;
            best = badge;
        }
    }
    if (!best) return NO;
    if (outBadge) *outBadge = best;
    return YES;
}

// Only claim touches that land on the badge, so taps elsewhere reach Telegram untouched.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)recognizer {
    return LeadBadgeHit(recognizer, NULL);
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)recognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(__unused UIGestureRecognizer *)other {
    return YES;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    LeadMessageBadge *badge = nil;
    if (LeadBadgeHit(recognizer, &badge)) LeadBadgeTapped(badge);
}
@end

static void LeadInstallBadgeTap(UIView *view, BOOL enabled) {
    UITapGestureRecognizer *tap = objc_getAssociatedObject(view, &LeadEditHistoryTapGestureKey);
    if (!enabled) {
        if (tap) {
            [view removeGestureRecognizer:tap];
            objc_setAssociatedObject(view, &LeadEditHistoryTapGestureKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return;
    }
    if (tap) return;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:[LeadBadgeTapTarget shared] action:@selector(handleTap:)];
    tap.cancelsTouchesInView = NO;
    tap.delegate = [LeadBadgeTapTarget shared];
    [view addGestureRecognizer:tap];
    objc_setAssociatedObject(view, &LeadEditHistoryTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static ASDisplayNode *findNodeByClassNamePrefix(ASDisplayNode *root, NSString *prefix);

// Outside the bubble, level with its top edge, on the side with free space:
// it never covers text, the time or Telegram's share/comment buttons.
static CGRect LeadRectInView(UIView *view, ASDisplayNode *node) {
    // Through layers: the bubble background may be layer-backed, where -view must not be touched.
    CALayer *layer = node.layer;
    if (!layer || layer.hidden) return CGRectNull;
    return [view.layer convertRect:layer.bounds fromLayer:layer];
}

// Outside the bubble, level with its top edge, on the side with free space:
// it never covers text, the time or Telegram's share/comment buttons.
// Returns NO while the bubble has no usable frame yet (mid-animation).
static BOOL LeadBadgeFrame(UIView *itemView, ASDisplayNode *itemNode, LeadMessageBadge *badge, CGRect *outFrame) {
    CGFloat side = LeadBadgeSide;
    CGSize size = itemView.bounds.size;
    if (size.width < 60) return NO;
    ASDisplayNode *bubble = findNodeByClassNamePrefix(itemNode, @"ChatMessageBackground");
    CGRect frame = bubble ? LeadRectInView(itemView, bubble) : CGRectNull;
    if (!CGRectIsNull(frame) && frame.size.width >= 30 && frame.size.height >= 20 &&
        CGRectGetMinX(frame) >= -1 && CGRectGetMaxX(frame) <= size.width + 1) {
        if (badge.side == 0) {
            badge.side = CGRectGetMidX(frame) > size.width / 2.0 ? -1 : 1;
        }
        BOOL outgoing = badge.side < 0;
        CGFloat x = outgoing ? CGRectGetMinX(frame) - side - 6 : CGRectGetMaxX(frame) + 6;
        CGFloat y = CGRectGetMinY(frame) + 3;
        if (x < 2 || x + side > size.width - 2) {
            // No room beside a full-width bubble: sit on its top corner instead.
            x = outgoing ? CGRectGetMinX(frame) - side / 3.0 : CGRectGetMaxX(frame) - side * 2.0 / 3.0;
            y = CGRectGetMinY(frame) - side / 3.0;
        }
        *outFrame = CGRectMake(MIN(MAX(0, x), size.width - side), MAX(0, y), side, side);
        return YES;
    }
    if (bubble) return NO;
    // Stickers, round videos: next to the time.
    ASDisplayNode *status = findNodeByClassNamePrefix(itemNode, @"ChatMessageDateAndStatusNode");
    frame = status ? LeadRectInView(itemView, status) : CGRectNull;
    if (CGRectIsNull(frame) || frame.size.width < 10) return NO;
    *outFrame = CGRectMake(MAX(0, CGRectGetMinX(frame) - side - 4), CGRectGetMidY(frame) - side / 2.0, side, side);
    return YES;
}

// Places the badge, and once more after Telegram's layout animation settles.
static void LeadPlaceBadge(LeadMessageBadge *badge, UIView *view, ASDisplayNode *node, BOOL settle) {
    CGRect frame;
    if (LeadBadgeFrame(view, node, badge, &frame)) {
        badge.frame = frame;
        badge.alpha = 1;
    } else if (badge.alpha > 0 && CGRectIsEmpty(badge.frame)) {
        badge.alpha = 0;
    }
    LeadMessageBadge *companion = badge.companion;
    if (companion && !companion.hidden) {
        // Under the trash badge; a one-line message is shorter than two badges, so
        // there it goes beside it, away from the bubble, to stay inside the row.
        CGRect below = CGRectOffset(badge.frame, 0, LeadBadgeSide + 4);
        CGFloat step = (badge.side < 0 ? -1 : 1) * (LeadBadgeSide + 4);
        CGRect beside = CGRectOffset(badge.frame, step, 0);
        BOOL fitsBelow = CGRectGetMaxY(below) <= view.bounds.size.height - 2;
        BOOL fitsBeside = CGRectGetMinX(beside) >= 2 && CGRectGetMaxX(beside) <= view.bounds.size.width - 2;
        companion.frame = (fitsBelow || !fitsBeside) ? below : beside;
        companion.alpha = badge.alpha;
    }
    if (!settle) return;
    __weak LeadMessageBadge *weakBadge = badge;
    __weak UIView *weakView = view;
    __weak ASDisplayNode *weakNode = node;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LeadMessageBadge *strongBadge = weakBadge;
        if (!strongBadge || strongBadge.hidden || !weakView || !weakNode) return;
        LeadPlaceBadge(strongBadge, weakView, weakNode, NO);
    });
}

static void LeadVideoToVoiceToast(NSString *text, UIColor *color) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = LeadMainWindow();
        if (!window) return;
        UILabel *toast = [[UILabel alloc] initWithFrame:CGRectZero];
        toast.text = text;
        toast.textColor = UIColor.whiteColor;
        toast.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
        toast.textAlignment = NSTextAlignmentCenter;
        toast.backgroundColor = color ?: [[UIColor blackColor] colorWithAlphaComponent:0.78];
        toast.layer.cornerRadius = 16.0;
        toast.layer.masksToBounds = YES;
        CGSize size = [toast sizeThatFits:CGSizeMake(window.bounds.size.width - 48.0, 44.0)];
        CGFloat width = MIN(window.bounds.size.width - 48.0, size.width + 28.0);
        toast.frame = CGRectMake((window.bounds.size.width - width) * 0.5, window.safeAreaInsets.top + 18.0, width, 34.0);
        toast.alpha = 0.0;
        [window addSubview:toast];
        [UIView animateWithDuration:0.16 animations:^{
            toast.alpha = 1.0;
        } completion:^(__unused BOOL finished) {
            [UIView animateWithDuration:0.18 delay:1.15 options:0 animations:^{
                toast.alpha = 0.0;
            } completion:^(__unused BOOL done) {
                [toast removeFromSuperview];
            }];
        }];
    });
}

static NSString *LeadVisualStarsFormattedAmount(void) {
    long long amount = [[[NSUserDefaults standardUserDefaults] objectForKey:kVisualStarsAmount] longLongValue];
    if (amount <= 0) amount = 0;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.groupingSeparator = @",";
    formatter.usesGroupingSeparator = YES;
    return [formatter stringFromNumber:@(amount)] ?: [NSString stringWithFormat:@"%lld", amount];
}

static BOOL LeadVisualStarsEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVisualStarsEnabled] &&
           [[[NSUserDefaults standardUserDefaults] objectForKey:kVisualStarsAmount] longLongValue] > 0;
}

static BOOL LeadStringIsNumericBalanceCandidate(NSString *text) {
    if (text.length == 0 || text.length > 24) return NO;
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
    BOOL hasDigit = NO;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar ch = [text characterAtIndex:i];
        if ([digits characterIsMember:ch]) {
            hasDigit = YES;
            continue;
        }
        if (ch == ',' || ch == '.' || ch == ' ' || ch == 0x00A0 || ch == 0x202F) {
            continue;
        }
        return NO;
    }
    return hasDigit;
}

static BOOL LeadTextLooksLikeStarsBalance(NSString *text) {
    if (text.length == 0) return NO;
    NSString *lower = text.localizedLowercaseString;
    BOOL hasStarsWord = [lower containsString:@"stars"] ||
                        [lower containsString:@"telegram stars"] ||
                        [lower containsString:@"xtr"];
    BOOL hasStarSymbol = [text containsString:@"⭐"] ||
                         [text containsString:@"★"] ||
                         [text containsString:@"✦"];
    if (!(hasStarsWord || hasStarSymbol)) return NO;
    return [text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound;
}

static BOOL LeadViewLooksLikeStarsBalanceContext(UIView *view, BOOL numericOnly) {
    UIView *current = view;
    for (NSUInteger depth = 0; current && depth < 10; depth++) {
        NSString *className = NSStringFromClass([current class]);
        NSString *lower = className.localizedLowercaseString;
        if ([lower containsString:@"starsbalance"] ||
            ([lower containsString:@"stars"] && [lower containsString:@"balance"]) ||
            ([lower containsString:@"gift"] && [lower containsString:@"balance"]) ||
            ([lower containsString:@"balance"] && ![lower containsString:@"slider"])) {
            return YES;
        }
        if (!numericOnly && ([lower containsString:@"starstransaction"] ||
                             [lower containsString:@"starspurchase"] ||
                             [lower containsString:@"starstransfer"])) {
            return YES;
        }
        current = current.superview;
    }
    UIResponder *responder = view.nextResponder;
    for (NSUInteger depth = 0; responder && depth < 8; depth++) {
        NSString *lower = NSStringFromClass([responder class]).localizedLowercaseString;
        if ([lower containsString:@"starsbalance"] ||
            ([lower containsString:@"stars"] && [lower containsString:@"balance"])) {
            return YES;
        }
        responder = responder.nextResponder;
    }
    return NO;
}

static NSString *LeadVisualStarsReplacementForText(NSString *text, UIView *view) {
    if (!LeadVisualStarsEnabled() || text.length == 0) return nil;
    BOOL numericOnly = LeadStringIsNumericBalanceCandidate(text);
    BOOL starsText = LeadTextLooksLikeStarsBalance(text);
    if (!numericOnly && !starsText) return nil;
    if (!LeadViewLooksLikeStarsBalanceContext(view, numericOnly)) return nil;

    NSString *amount = LeadVisualStarsFormattedAmount();
    if (starsText) {
        if ([text containsString:@"⭐"]) return [NSString stringWithFormat:@"⭐ %@", amount];
        if ([text containsString:@"★"]) return [NSString stringWithFormat:@"★ %@", amount];
        return [NSString stringWithFormat:@"%@ Stars", amount];
    }
    return amount;
}

%hook UILabel
- (void)setText:(NSString *)text {
    NSString *replacement = LeadVisualStarsReplacementForText(text, self);
    if (replacement.length > 0 && ![replacement isEqualToString:text]) {
        %orig(replacement);
        return;
    }
    %orig;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSString *plain = attributedText.string;
    NSString *replacement = LeadVisualStarsReplacementForText(plain, self);
    if (replacement.length > 0 && ![replacement isEqualToString:plain]) {
        NSDictionary *attrs = attributedText.length > 0 ? [attributedText attributesAtIndex:0 effectiveRange:nil] : @{};
        %orig([[NSAttributedString alloc] initWithString:replacement attributes:attrs]);
        return;
    }
    %orig;
}
%end


@interface LeadVideoToVoiceTarget : NSObject
+ (instancetype)shared;
- (void)toggle:(UIButton *)button;
- (void)sendDidFinish:(NSNotification *)notification;
@end

@implementation LeadVideoToVoiceTarget
+ (instancetype)shared {
    static LeadVideoToVoiceTarget *target = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        target = [LeadVideoToVoiceTarget new];
        [[NSNotificationCenter defaultCenter] addObserver:target
                                                 selector:@selector(sendDidFinish:)
                                                     name:@"LeadVideoToVoiceDidFinishSend"
                                                   object:nil];
    });
    return target;
}

- (void)sendDidFinish:(__unused NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kVideoToVoicePreviewEnabled];
}

- (void)toggle:(UIButton *)button {
    BOOL enabled = !button.selected;
    button.selected = enabled;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:enabled forKey:kVideoToVoicePreviewEnabled];
    if (!enabled) {
        [defaults removeObjectForKey:kVideoToVoiceLastDuration];
    }
    [defaults synchronize];

    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *feedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [feedback impactOccurred];
    }
    button.backgroundColor = enabled ? [[UIColor systemBlueColor] colorWithAlphaComponent:0.92] : [[UIColor blackColor] colorWithAlphaComponent:0.28];
    button.layer.borderWidth = enabled ? 1.5 : 0.0;
    button.layer.borderColor = enabled ? UIColor.whiteColor.CGColor : UIColor.clearColor.CGColor;

    LeadVideoToVoiceToast(enabled ? @"Video will be sent as voice" : @"Video will be sent normally",
                          [[UIColor blackColor] colorWithAlphaComponent:0.78]);
}
@end

static UIImage *LeadVideoToVoiceIcon(BOOL selected) {
    UIImage *image = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:selected ? @"waveform.circle.fill" : @"waveform.circle"];
    }
    return image ?: [UIImage systemImageNamed:@"mic.circle"];
}

static void LeadUpdateVideoToVoiceButtonStyle(UIButton *button, BOOL enabled) {
    button.selected = enabled;
    button.backgroundColor = enabled ? [[UIColor systemBlueColor] colorWithAlphaComponent:0.92] : [[UIColor blackColor] colorWithAlphaComponent:0.28];
    button.layer.borderWidth = enabled ? 1.5 : 0.0;
    button.layer.borderColor = enabled ? UIColor.whiteColor.CGColor : UIColor.clearColor.CGColor;
}

static UIButton *LeadEnsureVideoToVoiceButton(id interfaceView) {
    UIButton *button = objc_getAssociatedObject(interfaceView, &LeadVideoToVoiceButtonKey);
    if (button) return button;

    UIView *wrapper = nil;
    Ivar wrapperIvar = class_getInstanceVariable([interfaceView class], "_wrapperView");
    if (wrapperIvar) {
        wrapper = object_getIvar(interfaceView, wrapperIvar);
    }
    if (!wrapper) return nil;

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40.0, 40.0);
    button.adjustsImageWhenHighlighted = YES;
    button.tintColor = UIColor.whiteColor;
    button.layer.cornerRadius = 20.0;
    button.layer.masksToBounds = YES;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kVideoToVoicePreviewEnabled];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kVideoToVoiceLastDuration];
    [button setImage:LeadVideoToVoiceIcon(NO) forState:UIControlStateNormal];
    [button setImage:LeadVideoToVoiceIcon(YES) forState:UIControlStateSelected];
    LeadUpdateVideoToVoiceButtonStyle(button, NO);
    [button addTarget:[LeadVideoToVoiceTarget shared] action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    [wrapper addSubview:button];
    objc_setAssociatedObject(interfaceView, &LeadVideoToVoiceButtonKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return button;
}

static void LeadLayoutVideoToVoiceButton(id interfaceView) {
    UIButton *button = LeadEnsureVideoToVoiceButton(interfaceView);
    if (!button) return;

    UIView *anchor = nil;
    // Telegram: _roundVideoButton sits to the right of _muteButton.
    Ivar roundIvar = class_getInstanceVariable([interfaceView class], "_roundVideoButton");
    if (roundIvar) {
        UIView *v = object_getIvar(interfaceView, roundIvar);
        if (v && !v.hidden) anchor = v;
    }
    // Swiftgram: replaces _roundVideoButton with _telescopeButton (same position).
    if (!anchor) {
        Ivar telescopeIvar = class_getInstanceVariable([interfaceView class], "_telescopeButton");
        if (telescopeIvar) {
            UIView *v = object_getIvar(interfaceView, telescopeIvar);
            if (v && !v.hidden) anchor = v;
        }
    }
    // Last resort: mute button (visible when video can be sent as GIF).
    if (!anchor) {
        Ivar muteIvar = class_getInstanceVariable([interfaceView class], "_muteButton");
        if (muteIvar) anchor = object_getIvar(interfaceView, muteIvar);
    }
    if (!anchor) {
        button.hidden = YES;
        return;
    }
    button.hidden = anchor.hidden;
    button.alpha = anchor.alpha;
    button.userInteractionEnabled = !button.hidden;
    LeadUpdateVideoToVoiceButtonStyle(button, [[NSUserDefaults standardUserDefaults] boolForKey:kVideoToVoicePreviewEnabled]);
    button.frame = CGRectMake(CGRectGetMaxX(anchor.frame) + 8.0, anchor.frame.origin.y, 40.0, 40.0);
}

// Copy protection, ads and voice flags are handled at the MTProto layer
// (TLParser / FunctionHandler): Postbox.Message, TelegramMediaFile,
// ChatPresentationInterfaceState and LocalFileVideoMediaResource are pure
// Swift classes whose properties never go through objc_msgSend, so hooks on
// them never fired.

%hook TGMediaVideoConverter

+ (id)hashForAVAsset:(AVAsset *)avAsset adjustments:(id)adjustments {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kVideoToVoicePreviewEnabled]) {
        Class signalClass = NSClassFromString(@"SSignal");
        if (signalClass && [signalClass respondsToSelector:@selector(single:)]) {
            return ((id (*)(Class, SEL, id))objc_msgSend)(signalClass, @selector(single:), nil);
        }
    }
    return %orig;
}

%end

%hook TGMediaPickerGalleryInterfaceView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIButton *button = objc_getAssociatedObject(self, &LeadVideoToVoiceButtonKey);
    if (button && !button.hidden && button.alpha > 0.01 && button.userInteractionEnabled) {
        CGPoint buttonPoint = [button convertPoint:point fromView:(UIView *)self];
        if ([button pointInside:buttonPoint withEvent:event]) {
            return [button hitTest:buttonPoint withEvent:event] ?: button;
        }
    }
    return %orig;
}

- (void)layoutSubviews {
    %orig;
    LeadLayoutVideoToVoiceButton(self);
}

%end

%hook TGLocalization
- (id)get:(id)key {
    TGLocalizationShared = self;
    return %orig;
}

- (id)initWithVersion:(int)a code:(id)b dict:(id)c isActive:(BOOL)d {
    TGLocalization *instance = %orig;
    if (instance) TGLocalizationShared = instance;
    return instance;
}
%end

void showUI() {
	[Lead presentMenu];
}



// ============================================================
// Long-press to open Lead menu on "Ask a Question" row.
//
// Root cause of the language bug: didEnterHierarchy fires BEFORE
// update() sets accessibilityLabel, so the label is always empty
// at that point. The fix: hook setAccessibilityLabel: on
// AccessibilityAreaNode — it's called from update() with the
// correct localized text, regardless of language.
//
// "Ask a Question" is always id:0 in the .support section —
// its parent is always PeerInfoScreenDisclosureItemNode.
// We identify it by checking the parent node class + label.
// ============================================================

%hook ASDisplayNode

%property (nonatomic, strong) UILongPressGestureRecognizer *leadLongPressGesture;

- (void)setAccessibilityLabel:(NSString *)label {
    %orig;

    // Runs for every labelled node; the class check has to stay cheap.
    static Class areaNodeClass = Nil;
    if (!areaNodeClass) areaNodeClass = NSClassFromString(@"Display.AccessibilityAreaNode");
    if ([self class] != areaNodeClass) return;
    if (!label || label.length == 0) return;

    ASDisplayNode *parent = [self supernode];
    if (!parent) return;
    if (![NSStringFromClass([parent class]) containsString:@"DisclosureItemNode"]) return;

    NSString *lower = [label lowercaseString];
    BOOL isSupportRow = NO;

    // 1. Hardcoded common languages
    NSArray *known = @[
        @"ask a question", @"\u0437\u0430\u0434\u0430\u0442\u044c \u0432\u043e\u043f\u0440\u043e\u0441",
        @"hacer una pregunta", @"poser une question",
        @"about turrit", @"\u043e turrit", @"leadgram",
        @"stellen sie eine frage", @"fai una domanda", @"bir soru sor",
        @"\uc9c8\ubb38\ud558\uae30", @"\u63d0\u95ee", @"\u8cea\u554f\u3059\u308b",
        // Simplified Chinese: \u5173\u4e8eTurrit
        @"\u5173\u4e8eturrit",
        // Traditional Chinese: \u95dc\u65bcTurrit
        @"\u95dc\u65bcturrit"
    ];
    for (NSString *s in known) {
        if ([lower containsString:s]) { isSupportRow = YES; break; }
    }

    // 2. Active TGLocalization — works for any language
    if (!isSupportRow) {
        TGLocalization *loc = getActiveTGLocalization();
        if (loc) {
            NSString *str = [loc get:@"Settings.Support"];
            if (str.length > 0 && ![str isEqualToString:@"Settings.Support"]) {
                isSupportRow = [lower containsString:[str lowercaseString]];
            }
        }
    }

    if (!isSupportRow) {
        return;
    }

    if (!parent.leadLongPressGesture) {
        parent.leadLongPressGesture = [[UILongPressGestureRecognizer alloc]
            initWithTarget:parent
                    action:@selector(__handleLeadLongPress:)];
    }

    UIView *pv = parent.view;
    if (pv && ![pv.gestureRecognizers containsObject:parent.leadLongPressGesture]) {
        [pv addGestureRecognizer:parent.leadLongPressGesture];
        customLog2(@"[Lead] gesture attached: %@", label);
    }
}

%new
- (void)__handleLeadLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        showUI();
    }
}

%end



// // ============================================================
// // Lead nav bar button — liquid glass shield, injected into
// // GlassContextExtractableContainer (rightButtonsBackground).
// //
// // GlassContextExtractableContainer is a public UIView subclass
// // from GlassBackgroundComponent module. It wraps rightButtonsContainer
// // which holds the Edit button. We hook its layoutSubviews and add
// // our button to its contentView (normalContentView).
// // ============================================================
// 
// @interface _TtC24GlassBackgroundComponent31GlassContextExtractableContainer : UIView
// @property (nonatomic, strong, readonly) UIView *contentView;
// @end
// 
// %hook _TtC24GlassBackgroundComponent31GlassContextExtractableContainer
// 
// - (void)layoutSubviews {
//     %orig;
//     @try {
//         // Already injected
//         if ([self viewWithTag:9876]) return;
// 
//         // contentView holds rightButtonsContainer
//         UIView *cv = self.contentView;
//         if (!cv) return;
// 
//         // rightButtonsContainer must have a NavigationButton subview
//         BOOL hasNavBtn = NO;
//         for (UIView *sub in cv.subviews) {
//             NSString *cls = NSStringFromClass([sub class]);
//             if ([cls containsString:@"NavigationButton"] || [cls containsString:@"HighlightableButton"]) {
//                 hasNavBtn = YES; break;
//             }
//         }
//         if (!hasNavBtn) return;
// 
//         CGFloat h = cv.bounds.size.height;
//         if (h < 20 || h > 60) return;
// 
//         // Build liquid glass button
//         CGFloat btnW = h;
//         UIButton *leadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//         leadBtn.tag = 9876;
//         leadBtn.frame = CGRectMake(-(btnW + 8), 0, btnW, h);
//         leadBtn.layer.cornerRadius = h * 0.5;
//         leadBtn.clipsToBounds = YES;
// 
//         // Blur background (liquid glass)
//         UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
//         UIVisualEffectView *glass = [[UIVisualEffectView alloc] initWithEffect:blur];
//         glass.frame = leadBtn.bounds;
//         glass.layer.cornerRadius = h * 0.5;
//         glass.clipsToBounds = YES;
//         glass.userInteractionEnabled = NO;
//         [leadBtn insertSubview:glass atIndex:0];
// 
//         // Shield icon
//         UIImage *icon = [UIImage systemImageNamed:@"shield.lefthalf.filled"];
//         if (!icon) icon = [UIImage systemImageNamed:@"shield.fill"];
//         UIImageSymbolConfiguration *cfg = [UIImageSymbolConfiguration
//             configurationWithPointSize:15 weight:UIImageSymbolWeightMedium];
//         if (cfg) icon = [icon imageByApplyingSymbolConfiguration:cfg];
//         [leadBtn setImage:icon forState:UIControlStateNormal];
//         leadBtn.tintColor = [UIColor labelColor];
// 
//         [leadBtn addTarget:self action:@selector(__leadShieldTap)
//               forControlEvents:UIControlEventTouchUpInside];
// 
//         // Widen contentView to show the button
//         CGRect cvf = cv.frame;
//         cvf.origin.x -= (btnW + 8);
//         cvf.size.width += (btnW + 8);
//         cv.frame = cvf;
//         cv.clipsToBounds = NO;
// 
//         [cv addSubview:leadBtn];
//         customLog2(@"[Lead] shield button injected h=%.0f", h);
//     } @catch (NSException *e) {
//         customLog2(@"[Lead] shield inject error: %@", e);
//     }
// }
// 
// %new
// - (void)__leadShieldTap {
//     showUI();
// }
// 
// %end
// 


static void showWelcomeAlertIfNeeded() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"LeadWelcomeShown"]) return;

    UIWindow *window = LeadMainWindow();
    UIViewController *rootVC = window.rootViewController;
    if (!rootVC) return;

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"Lead"
        message:@"Lead has been successfully injected into Telegram.\n\nTo open the tweak menu: long-press the \"Ask a Question\" row in Settings."
        preferredStyle:UIAlertControllerStyleAlert];

    void (^markShown)(void) = ^{
        [defaults setBool:YES forKey:@"LeadWelcomeShown"];
        [defaults synchronize];
    };

    UIAlertAction *channelAction = [UIAlertAction
        actionWithTitle:@"Join Channel →"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
        markShown();
        NSURL *url = [NSURL URLWithString:@"https://t.me/Leadgramm"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }];

    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:@"OK"
                  style:UIAlertActionStyleCancel
                handler:^(UIAlertAction *action) {
        markShown();
    }];

    [alert addAction:channelAction];
    [alert addAction:okAction];

    [rootVC presentViewController:alert animated:YES completion:nil];
}

#import "../Headers.h"

@interface ASDisplayNode (TGExtra)
@property (nonatomic, readonly) UIView *view;
@property (nonatomic, copy, readonly) NSArray *subnodes;
@end

static ASDisplayNode *findNodeByClassNamePrefix(ASDisplayNode *root, NSString *prefix) {
    if (!root) return nil;
    if ([NSStringFromClass([root class]) containsString:prefix]) {
        return root;
    }
    @try {
        NSArray *subs = root.subnodes;
        for (ASDisplayNode *child in subs) {
            ASDisplayNode *found = findNodeByClassNamePrefix(child, prefix);
            if (found) return found;
        }
    } @catch (NSException *e) {}
    return nil;
}

static void injectBadgeToNode(ASDisplayNode *textNode, ASDisplayNode *headerNode, long long peerId) {
    @try {
        if (!textNode.view || !headerNode.view) return;

        if (peerId == 0) {
            NSString *cls = NSStringFromClass([headerNode class]);
            if ([cls containsString:@"Settings"] || [cls containsString:@"Profile"]) {
                peerId = [[NSUserDefaults standardUserDefaults] integerForKey:@"LeadLastKnownUserId"];
            }
        }

        if (peerId == 0) return;

        NSString *prefix = nil;
        UIColor *badgeColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0]; // Lead Blue

        // Add your IDs here
        if (peerId == 5576711589 || peerId == 7846965839) {
            prefix = @"👑 Lead Owner";
            badgeColor = [UIColor colorWithRed:1.0 green:0.75 blue:0.0 alpha:1.0]; // Gold
        } else {
            NSNumber *currId = [NSClassFromString(@"TLParser") performSelector:@selector(getCurrentUserId)];
            if (currId && [currId longLongValue] == peerId) {
                prefix = @"✨ Lead User";
            }
        }
        
        if (!prefix) {
            UIView *oldBadge = [headerNode.view viewWithTag:9988];
            if (oldBadge) [oldBadge removeFromSuperview];
            return;
        }

        UILabel *badge = (UILabel *)[headerNode.view viewWithTag:9988];
        if (!badge) {
            badge = [[UILabel alloc] init];
            badge.tag = 9988;
            badge.font = [UIFont boldSystemFontOfSize:10];
            badge.textColor = [UIColor whiteColor];
            badge.layer.cornerRadius = 4;
            badge.layer.masksToBounds = YES;
            badge.layer.zPosition = 9999;
            [headerNode.view addSubview:badge];
        }
        
        badge.backgroundColor = badgeColor;
        badge.text = [NSString stringWithFormat:@" %@ ", prefix];
        [badge sizeToFit];
        
        CGRect textFrame = [textNode.view convertRect:textNode.view.bounds toView:headerNode.view];
        if (textFrame.size.width > 0) {
            badge.frame = CGRectMake(textFrame.origin.x + textFrame.size.width + 6, 
                                     textFrame.origin.y + (textFrame.size.height - badge.frame.size.height) / 2.0, 
                                     badge.frame.size.width, badge.frame.size.height);
        } else {
            badge.frame = CGRectMake(headerNode.view.frame.size.width - badge.frame.size.width - 15, 45, badge.frame.size.width, badge.frame.size.height);
        }
        badge.hidden = NO;
        [headerNode.view bringSubviewToFront:badge];
    } @catch (NSException *e) {}
}

@interface LeadGhostProfileTarget : NSObject
@property(nonatomic, assign) long long peerId;
@property(nonatomic, copy) NSString *primaryKey;
@property(nonatomic, copy) NSArray *aliases;
@property(nonatomic, copy) NSString *peerTitle;
@property(nonatomic, weak) UIBarButtonItem *barItem;
@property(nonatomic, weak) UIViewController *controller;
- (void)toggleGhostException;
@end
@implementation LeadGhostProfileTarget
static char LeadGhostTargetKey;
static void LeadInstallGhostNavItem(UIViewController *controller);
static void LeadInstallProfileItems(UIViewController *controller);
static BOOL LeadIsUsableGhostTitle(NSString *title);
static NSString *LeadPeerTitleFromObject(id object);

static NSArray *LeadGhostAliasesForLooseId(long long looseId, NSString *primaryKey) {
    NSMutableArray *aliases = [NSMutableArray array];
    if (primaryKey.length > 0) [aliases addObject:primaryKey];
    if (looseId != 0) {
        [aliases addObject:LeadPeerKey(@"user", looseId)];
        [aliases addObject:LeadPeerKey(@"channel", looseId)];
        [aliases addObject:LeadPeerKey(@"chat", looseId)];
    }
    return aliases;
}

static void LeadUpdateGhostBarItem(UIBarButtonItem *item, BOOL enabled) {
    UIImageSymbolConfiguration *config =
        [UIImageSymbolConfiguration configurationWithPointSize:20.0
                                                        weight:UIImageSymbolWeightSemibold];
    UIImage *image = [[UIImage systemImageNamed:(enabled ? @"eye.fill" : @"eye.slash")]
        imageWithConfiguration:config];
    [UIView performWithoutAnimation:^{
        item.image = image;
        item.title = nil;
        item.tintColor = enabled ? [UIColor systemGreenColor] : nil;
        item.accessibilityLabel = enabled ? @"Ghost exception enabled" : @"Ghost exception disabled";
    }];
}

- (void)toggleGhostException {
    NSString *primaryKey = self.primaryKey;
    NSArray *aliases = self.aliases;
    if (primaryKey.length == 0) return;
    BOOL enabled = LeadIsGhostPeerEnabledForKeys(aliases);

    // Data is definitely loaded by toggle time — retry if we stored a bad title.
    NSString *title = self.peerTitle;
    if (!LeadIsUsableGhostTitle(title) && self.controller) {
        NSString *fresh = LeadPeerTitleFromObject(self.controller);
        if (LeadIsUsableGhostTitle(fresh)) {
            title = fresh;
            self.peerTitle = fresh;
        } else {
            title = primaryKey;
        }
    }

    LeadSetGhostPeerEnabled(primaryKey, aliases, title, !enabled);
    if (self.barItem) {
        LeadUpdateGhostBarItem(self.barItem, !enabled);
    }
    UIViewController *controller = self.controller;
    if (controller) {
        // The whole set, so on the old base the item moves back into the header row
        // instead of staying on the bar over Telegram's own buttons.
        dispatch_async(dispatch_get_main_queue(), ^{
            LeadInstallProfileItems(controller);
        });
    }
}
@end

static long long LeadPeerIdFromObject(id object) {
    if (!object) return 0;
    @try {
        NSNumber *peerNumber = [NSClassFromString(@"TLParser") performSelector:@selector(getPeerIdFromNode:) withObject:object];
        if (peerNumber) return [peerNumber longLongValue];
    } @catch (NSException *e) {}
    return 0;
}

static NSInteger LeadPeerNamespaceFromObject(id object) {
    if (!object) return NSNotFound;
    @try {
        NSNumber *namespaceNumber = [NSClassFromString(@"TLParser") performSelector:@selector(getPeerNamespaceFromNode:) withObject:object];
        if (namespaceNumber) return [namespaceNumber integerValue];
    } @catch (NSException *e) {}
    return NSNotFound;
}

static NSString *LeadPeerTitleFromObject(id object) {
    if (!object) return nil;
    @try {
        NSString *title = [NSClassFromString(@"TLParser") performSelector:@selector(getPeerDisplayTitleFromNode:) withObject:object];
        if (LeadIsUsableGhostTitle(title)) return title;
    } @catch (NSException *e) {}
    @try {
        if ([object isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController *)object;
            NSArray<NSString *> *candidates = @[
                controller.navigationItem.title ?: @"",
                controller.title ?: @""
            ];
            for (NSString *candidate in candidates) {
                if (LeadIsUsableGhostTitle(candidate)) return candidate;
            }
        }
    } @catch (NSException *e) {}
    return nil;
}

static BOOL LeadIsSettingsOrMyProfileObject(id object) {
    if (!object) return YES;
    @try {
        NSNumber *result = [NSClassFromString(@"TLParser") performSelector:@selector(isSettingsOrMyProfileNode:) withObject:object];
        return result && [result boolValue];
    } @catch (NSException *e) {}
    return NO;
}

static BOOL LeadIsCurrentUserPeer(long long peerId) {
    if (peerId == 0) return YES;
    @try {
        NSNumber *currId = [NSClassFromString(@"TLParser") performSelector:@selector(getCurrentUserId)];
        return currId && [currId longLongValue] == peerId;
    } @catch (NSException *e) {}
    return NO;
}

static BOOL LeadGhostControlsShouldBeVisible(void) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:kGhostModeEnabled]) return NO;
    for (NSString *key in LeadGhostFeatureKeys()) {
        if ([defaults boolForKey:key]) return YES;
    }
    return NO;
}

static BOOL LeadIsUsableGhostTitle(NSString *title) {
    if (title.length == 0 || title.length >= 80) return NO;
    NSString *trimmed = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmed.length == 0 || [trimmed hasPrefix:@"+"]) return NO;
    NSString *lower = title.localizedLowercaseString;
    NSArray *blockedExact = @[
        @"username", @"addressname", @"firstname", @"lastname", @"title",
        @"peer", @"_peer", @"message", @"call",
        @"video call", @"mute", @"notifications", @"bio", @"about", @"info",
        @"edit", @"done", @"settings", @"add to contacts", @"add contact",
        @"contact", @"invite", @"more", @"back", @"block user", @"block",
        @"report", @"delete contact", @"share contact", @"send message"
    ];
    for (NSString *word in blockedExact) {
        if ([lower isEqualToString:word]) {
            return NO;
        }
    }
    if ([lower containsString:@"share qr"] || [lower containsString:@"qr code"]) return NO;
    return YES;
}

static void LeadInstallGhostNavItem(UIViewController *controller) {
    @try {
        if (!controller || !controller.navigationItem) return;

        UIBarButtonItem *ghostItem = nil;
        NSMutableArray *rightItems = [NSMutableArray array];
        for (UIBarButtonItem *item in controller.navigationItem.rightBarButtonItems ?: @[]) {
            if ([item.accessibilityIdentifier isEqualToString:@"LeadGhostExceptionBarItem"]) {
                if (!ghostItem) ghostItem = item;
                continue;
            }
            [rightItems addObject:item];
        }

        if (!LeadGhostControlsShouldBeVisible()) {
            if (ghostItem) {
                [UIView performWithoutAnimation:^{
                    controller.navigationItem.rightBarButtonItems = rightItems;
                }];
            }
            return;
        }

        if (LeadIsSettingsOrMyProfileObject(controller)) {
            if (ghostItem) {
                [UIView performWithoutAnimation:^{
                    controller.navigationItem.rightBarButtonItems = rightItems;
                }];
            }
            return;
        }

        long long peerId = LeadPeerIdFromObject(controller);
        if (peerId == 0 || LeadIsCurrentUserPeer(peerId)) {
            if (ghostItem) {
                [UIView performWithoutAnimation:^{
                    controller.navigationItem.rightBarButtonItems = rightItems;
                }];
            }
            return;
        }

        // Channels share a namespace with supergroups. Nobody sees who read a broadcast
        // channel, but a supergroup is a chat like any other; until the profile has
        // loaded the two can't be told apart, and a later pass adds the button.
        NSInteger peerNamespace = LeadPeerNamespaceFromObject(controller);
        BOOL isSupergroup = peerNamespace == 2 && [TLParser channelKindFromController:controller].intValue == 1;
        if (peerNamespace == 2 && !isSupergroup) {
            if (ghostItem) {
                [UIView performWithoutAnimation:^{
                    controller.navigationItem.rightBarButtonItems = rightItems;
                }];
            }
            return;
        }

        NSString *primaryKey = isSupergroup ? LeadPeerKey(@"channel", peerId) : LeadPeerKey(@"peer", peerId);
        NSArray *aliases = isSupergroup ? @[ primaryKey ] : LeadGhostAliasesForLooseId(peerId, primaryKey);
        BOOL enabled = LeadIsGhostPeerEnabledForKeys(aliases);
        [[NSUserDefaults standardUserDefaults]
            setObject:@{@"peerId": @(peerId), @"time": @([[NSDate date] timeIntervalSince1970])}
               forKey:@"LeadCurrentProfilePeer"];

        LeadGhostProfileTarget *target = ghostItem ? objc_getAssociatedObject(ghostItem, &LeadGhostTargetKey) : nil;
        if (!target) target = [LeadGhostProfileTarget new];

        if (!ghostItem) {
            ghostItem = [[UIBarButtonItem alloc] initWithImage:nil
                                                         style:UIBarButtonItemStylePlain
                                                        target:target
                                                        action:@selector(toggleGhostException)];
            ghostItem.accessibilityIdentifier = @"LeadGhostExceptionBarItem";

        } else {
            ghostItem.target = target;
            ghostItem.action = @selector(toggleGhostException);
        }

        [rightItems insertObject:ghostItem atIndex:0];
        [UIView performWithoutAnimation:^{
            controller.navigationItem.rightBarButtonItems = rightItems;
        }];

        NSString *title = LeadPeerTitleFromObject(controller);
        if (!LeadIsUsableGhostTitle(title)) title = primaryKey;
        target.peerId = peerId;
        target.primaryKey = primaryKey;
        target.aliases = aliases;
        target.peerTitle = title;
        target.barItem = ghostItem;
        target.controller = controller;
        objc_setAssociatedObject(ghostItem, &LeadGhostTargetKey, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (enabled && LeadIsUsableGhostTitle(title)) {
            LeadSetGhostPeerEnabled(primaryKey, aliases, title, YES);
        }
        LeadUpdateGhostBarItem(ghostItem, enabled);
    } @catch (NSException *e) {}
}

static void removeGhostButtonFromHeader(ASDisplayNode *headerNode) {
    @try {
        UIView *oldButton = [headerNode.view viewWithTag:9989];
        if (oldButton) [oldButton removeFromSuperview];
    } @catch (NSException *e) {}
}

static void recursiveSearchAndInject(ASDisplayNode *node, ASDisplayNode *header, long long peerId) {
    if (!node) return;
    NSString *cls = NSStringFromClass([node class]);

    if (node == header) {
        removeGhostButtonFromHeader(header);
    }
    
    if ([cls containsString:@"TextNode"] && ![cls containsString:@"Accessibility"] && ![cls containsString:@"Button"]) {
        injectBadgeToNode(node, header, peerId);
        removeGhostButtonFromHeader(header);
    }
    @try {
        NSArray *subs = node.subnodes;
        for (ASDisplayNode *sub in subs) {
            recursiveSearchAndInject(sub, header, peerId);
        }
    } @catch (NSException *e) {}
}

static NSHashTable *activeMessageNodes = nil;

@interface LeadAntiRevokeUpdater : NSObject
@end
@implementation LeadAntiRevokeUpdater
+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleDeleted:) name:@"LeadMessageDeletedRealtime" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleDeleted:) name:@"LeadMessageEditedRealtime" object:nil];
    });
    return instance;
}
- (void)handleDeleted:(NSNotification *)note {
    NSArray *deletedIds = note.userInfo[@"ids"];
    if (!deletedIds || deletedIds.count == 0) return;
    
    NSHashTable *nodesCopy = nil;
    @synchronized(activeMessageNodes) {
        nodesCopy = [activeMessageNodes copy];
    }
    
    for (ASDisplayNode *node in nodesCopy) {
        NSNumber *msgId = [TLParser getMessageIdFromNode:node];
        if (msgId && [deletedIds containsObject:msgId]) {
            [node setNeedsLayout];
            [node.view setNeedsLayout];
        }
    }
}
@end

typedef NS_ENUM(NSInteger, LeadNodeKind) {
    LeadNodeKindOther,
    LeadNodeKindMessageItem,      // ChatMessage…ItemNode: deleted/edited/timer badges
    LeadNodeKindProfileHeader,    // the name/avatar header of a profile or Settings
    LeadNodeKindHeaderButtons,    // PeerInfoHeaderNavigationButtonContainerNode (pre-13.1 base)
};

static char LeadHeaderInjectKey;
static char LeadHeaderInjectPendingKey;

static void LeadInjectProfileHeader(ASDisplayNode *header) {
    long long peerId = LeadPeerIdFromObject(header);
    if (peerId == 0) {
        peerId = [[NSUserDefaults standardUserDefaults] integerForKey:@"LeadLastKnownUserId"];
    }
    recursiveSearchAndInject(header, header, peerId);
}

// Class → kind, worked out once per class instead of string checks on every layout.
static LeadNodeKind LeadNodeKindForClass(Class cls) {
    static NSMapTable<Class, NSNumber *> *cache;
    static os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ cache = [NSMapTable strongToStrongObjectsMapTable]; });
    os_unfair_lock_lock(&lock);
    NSNumber *known = [cache objectForKey:cls];
    os_unfair_lock_unlock(&lock);
    if (known) return (LeadNodeKind)known.integerValue;

    NSString *name = NSStringFromClass(cls);
    LeadNodeKind kind = LeadNodeKindOther;
    if ([name hasSuffix:@"PeerInfoHeaderNavigationButtonContainerNode"]) {
        kind = LeadNodeKindHeaderButtons;
    } else if ([name hasSuffix:@"PeerInfoHeaderNode"] || [name containsString:@"UserInfoHeader"] || [name containsString:@"ContactInfoHeader"]) {
        kind = LeadNodeKindProfileHeader;
    } else if ([name containsString:@"ChatMessage"] && [name containsString:@"ItemNode"]) {
        kind = LeadNodeKindMessageItem;
    }
    os_unfair_lock_lock(&lock);
    [cache setObject:@(kind) forKey:cls];
    os_unfair_lock_unlock(&lock);
    return kind;
}

// Profiles on the pre-13.1 base (Swiftgram 13.0) draw their own Edit/More buttons
// in PeerInfoHeaderNavigationButtonContainerNode, over the navigation bar; bar
// items added there land on top of them. There Lead's two buttons move out of the
// bar into a small row placed just left of the header's own buttons.
static char LeadHeaderRowKey;

// Associated objects can't be weak; this box holds the row weakly for the container.
@interface LeadWeakBox : NSObject
@property (nonatomic, weak) id value;
@end
@implementation LeadWeakBox
@end

@interface LeadHeaderButtonRow : UIView
@property (nonatomic, strong) NSArray<UIBarButtonItem *> *items;
@property (nonatomic, weak) ASDisplayNode *container;
- (void)reload;
- (void)place;
@end

@implementation LeadHeaderButtonRow
- (void)reload {
    for (UIView *view in self.subviews) [view removeFromSuperview];
    CGFloat side = 40, gap = 8, x = 0;
    for (UIBarButtonItem *item in self.items) {
        UIVisualEffectView *glass = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterial]];
        glass.frame = CGRectMake(x, 0, side, side);
        glass.layer.cornerRadius = side / 2;
        glass.clipsToBounds = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = glass.bounds;
        UIImage *image = [item.image imageWithConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:17 weight:UIImageSymbolWeightSemibold]];
        [button setImage:image forState:UIControlStateNormal];
        button.tintColor = item.tintColor ?: UIColor.labelColor;
        button.accessibilityLabel = item.accessibilityLabel;
        objc_setAssociatedObject(button, &LeadHeaderRowKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [button addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
        [glass.contentView addSubview:button];
        [self addSubview:glass];
        x += side + gap;
    }
    CGRect frame = self.frame;
    frame.size = CGSizeMake(MAX(0, x - gap), side);
    self.frame = frame;
}

- (void)tapped:(UIButton *)button {
    UIBarButtonItem *item = objc_getAssociatedObject(button, &LeadHeaderRowKey);
    if (item.target && item.action) {
        ((void (*)(id, SEL, id))objc_msgSend)(item.target, item.action, item);
    }
    // The ghost item swaps its icon and tint after a toggle.
    dispatch_async(dispatch_get_main_queue(), ^{ [self reload]; [self place]; });
}

// Just left of the leftmost visible header button on the right half.
- (void)place {
    ASDisplayNode *container = self.container;
    UIView *host = self.superview;
    if (!container.view || !host) { self.hidden = YES; return; }
    CGFloat minX = CGFLOAT_MAX, midY = 0;
    for (ASDisplayNode *child in container.subnodes ?: @[]) {
        UIView *view = child.view;
        if (!view || view.hidden || view.alpha < 0.01 || view.bounds.size.width < 1) continue;
        CGRect frame = [host convertRect:view.bounds fromView:view];
        if (CGRectGetMidX(frame) < host.bounds.size.width / 2) continue;
        if (CGRectGetMinX(frame) < minX) {
            minX = CGRectGetMinX(frame);
            midY = CGRectGetMidY(frame);
        }
    }
    if (minX == CGFLOAT_MAX) { self.hidden = YES; return; }
    self.hidden = NO;
    CGRect frame = self.frame;
    frame.origin = CGPointMake(minX - 8 - frame.size.width, midY - frame.size.height / 2);
    self.frame = frame;
    [host bringSubviewToFront:self];
}
@end

static ASDisplayNode *LeadNodeForView(UIView *view) {
    SEL getter = NSSelectorFromString(@"asyncdisplaykit_node");
    if (![view respondsToSelector:getter]) return nil;
    return ((id (*)(id, SEL))objc_msgSend)(view, getter);
}

static void LeadPlaceHeaderRow(UIViewController *controller) {
    ASDisplayNode *root = LeadNodeForView(controller.view);
    ASDisplayNode *container = root ? findNodeByClassNamePrefix(root, @"PeerInfoHeaderNavigationButtonContainerNode") : nil;
    LeadHeaderButtonRow *row = objc_getAssociatedObject(controller, &LeadHeaderRowKey);
    if (!container) {
        [row removeFromSuperview];
        objc_setAssociatedObject(controller, &LeadHeaderRowKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    NSMutableArray *native = [NSMutableArray array];
    NSMutableArray *ours = [NSMutableArray array];
    for (UIBarButtonItem *item in controller.navigationItem.rightBarButtonItems ?: @[]) {
        BOOL isLead = [item.accessibilityIdentifier isEqualToString:@"LeadGhostExceptionBarItem"] ||
                      [item.accessibilityIdentifier isEqualToString:@"LeadPeerInfoBarItem"];
        [(isLead ? ours : native) addObject:item];
    }
    if (ours.count) {
        [UIView performWithoutAnimation:^{
            controller.navigationItem.rightBarButtonItems = native;
        }];
    } else if (row) {
        // Nothing new to move: keep the row as is (the items already live in it).
        ours = [row.items mutableCopy];
    }
    if (!row) {
        row = [LeadHeaderButtonRow new];
        objc_setAssociatedObject(controller, &LeadHeaderRowKey, row, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (row.superview != controller.view) [controller.view addSubview:row];
    row.container = container;
    LeadWeakBox *box = [LeadWeakBox new];
    box.value = row;
    objc_setAssociatedObject(container, &LeadHeaderRowKey, box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    row.items = ours;
    [row reload];
    [row place];
    row.hidden = row.hidden || ours.count == 0;
}

%hook ASDisplayNode
- (void)layout {
    %orig;

    // Runs for every node Telegram lays out, so decide what the class is once.
    LeadNodeKind nodeKind = LeadNodeKindForClass([self class]);
    if (nodeKind == LeadNodeKindOther) return;

    if (nodeKind == LeadNodeKindHeaderButtons) {
        LeadHeaderButtonRow *row = ((LeadWeakBox *)objc_getAssociatedObject(self, &LeadHeaderRowKey)).value;
        if (row) dispatch_async(dispatch_get_main_queue(), ^{ [row place]; });
        return;
    }

    if (nodeKind == LeadNodeKindProfileHeader) {
        // The header lays out on every scroll step; the badge doesn't need that.
        CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
        NSNumber *last = objc_getAssociatedObject(self, &LeadHeaderInjectKey);
        if (last && now - last.doubleValue < 0.3) {
            // One more run after the burst: the last layout may be the one that has the
            // peer loaded, and the badge must not stay on what the first one saw.
            if (!objc_getAssociatedObject(self, &LeadHeaderInjectPendingKey)) {
                objc_setAssociatedObject(self, &LeadHeaderInjectPendingKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                __weak ASDisplayNode *weakHeader = (ASDisplayNode *)self;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ASDisplayNode *header = weakHeader;
                    if (!header) return;
                    objc_setAssociatedObject(header, &LeadHeaderInjectPendingKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    objc_setAssociatedObject(header, &LeadHeaderInjectKey, @(CFAbsoluteTimeGetCurrent()), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    LeadInjectProfileHeader(header);
                });
            }
            return;
        }
        objc_setAssociatedObject(self, &LeadHeaderInjectKey, @(now), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        LeadInjectProfileHeader((ASDisplayNode *)self);
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activeMessageNodes = [NSHashTable weakObjectsHashTable];
    });
    
    @synchronized(activeMessageNodes) {
        [activeMessageNodes addObject:self];
    }
    
    NSNumber *msgId = [TLParser getMessageIdFromNode:self];
    if (msgId && [TLParser diagEnabled]) {
        [TLParser diagNode:self];
    }
    if (msgId && [[NSUserDefaults standardUserDefaults] boolForKey:kAntiEdit]) {
        [TLParser observeMessageTextFromNode:self];
    }
    BOOL isDeletedMsg = (msgId && [TLParser isDeletedMessageNode:self]);
    BOOL isEditedMsg = (msgId && [TLParser isEditedMessageNode:self]);
    BOOL isSelfDestructMsg = (msgId && [TLParser isSelfDestructingMessageNode:self]);
    LeadBadgeKind kind = isDeletedMsg ? LeadBadgeKindDeleted : isEditedMsg ? LeadBadgeKindEdited : isSelfDestructMsg ? LeadBadgeKindTimer : LeadBadgeKindNone;
    NSString *editKey = isEditedMsg ? [TLParser editKeyForNode:self] : nil;
    NSString *peerTag = msgId ? [TLParser peerTagForNode:self] : nil;

    ASDisplayNode *node = (ASDisplayNode *)self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = node.view;
        if (!view) return;
        LeadMessageBadge *badge = LeadBadgeInView(view);
        LeadMessageBadge *secondary = LeadSecondaryBadgeInView(view);
        LeadInstallBadgeTap(view, kind == LeadBadgeKindDeleted || kind == LeadBadgeKindEdited);
        BOOL wantsSecondary = kind == LeadBadgeKindDeleted && isEditedMsg;
        if (!wantsSecondary && secondary) {
            secondary.hidden = YES;
            secondary.kind = LeadBadgeKindNone;
        }
        if (kind == LeadBadgeKindNone) {
            badge.hidden = YES;
            badge.kind = LeadBadgeKindNone;
            return;
        }
        BOOL appearing = !badge || badge.hidden;
        if (!badge) {
            badge = [[LeadMessageBadge alloc] initWithFrame:CGRectZero];
            [view addSubview:badge];
        }
        // The item view can be rebound to another message.
        if (![badge.messageId isEqual:msgId] || ![badge.peerTag ?: @"" isEqualToString:peerTag ?: @""]) badge.side = 0;
        badge.alsoEdited = isEditedMsg;
        badge.editKey = editKey;
        badge.peerTag = peerTag;
        badge.messageId = msgId;
        badge.hidden = NO;
        [view bringSubviewToFront:badge];
        if (appearing) badge.kind = LeadBadgeKindNone;
        [badge setKind:kind animated:YES];
        if (wantsSecondary) {
            BOOL secondaryAppearing = !secondary || secondary.hidden;
            if (!secondary) {
                secondary = [[LeadMessageBadge alloc] initWithFrame:CGRectZero];
                secondary.isSecondary = YES;
                [view addSubview:secondary];
            }
            secondary.editKey = editKey;
            secondary.peerTag = peerTag;
            secondary.messageId = msgId;
            secondary.hidden = NO;
            [view bringSubviewToFront:secondary];
            if (secondaryAppearing) secondary.kind = LeadBadgeKindNone;
            [secondary setKind:LeadBadgeKindEdited animated:YES];
            badge.companion = secondary;
        } else {
            badge.companion = nil;
        }
        LeadPlaceBadge(badge, view, node, YES);
    });
}
%end

// "#" button on profiles: copy the Bot-API style ID, see the estimated sign-up year.
// Telegram draws bar items with its own navigation bar, which honours target/action
// but ignores UIKit's UIBarButtonItem.menu — so the tap opens an action sheet.
@interface LeadPeerInfoTarget : NSObject
@property (nonatomic, copy) NSString *idText;
@property (nonatomic, copy) NSString *registered;
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, weak) UIBarButtonItem *barItem;
- (void)showPeerInfo;
@end

@implementation LeadPeerInfoTarget
- (void)showPeerInfo {
    UIViewController *controller = self.controller;
    if (!controller || !self.idText) return;
    LeadSelectionHaptic();
    NSString *message = self.registered ? [NSString stringWithFormat:LeadL(@"UI_PEER_REGISTERED"), self.registered] : nil;
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"ID %@", self.idText]
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    NSString *idText = self.idText;
    __weak UIViewController *weakController = controller;
    UIAlertAction *copy = [UIAlertAction actionWithTitle:LeadL(@"UI_COPY") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        [UIPasteboard generalPasteboard].string = idText;
        [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:weakController.view];
    }];
    @try {
        [copy setValue:[UIImage systemImageNamed:@"doc.on.doc"] forKey:@"image"];
    } @catch (__unused NSException *exception) {}
    [sheet addAction:copy];
    [sheet addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
    sheet.popoverPresentationController.barButtonItem = self.barItem;
    if (!self.barItem) {
        sheet.popoverPresentationController.sourceView = controller.view;
        sheet.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMaxX(controller.view.bounds) - 40, 60, 1, 1);
    }
    UIViewController *presenter = controller;
    while (presenter.presentedViewController && !presenter.presentedViewController.isBeingDismissed) {
        presenter = presenter.presentedViewController;
    }
    [presenter presentViewController:sheet animated:YES completion:nil];
}
@end

static char LeadPeerInfoTargetKey;

static void LeadInstallPeerInfoItem(UIViewController *controller) {
    @try {
        if (!controller.navigationItem) return;
        UIBarButtonItem *existing = nil;
        NSMutableArray *items = [NSMutableArray array];
        for (UIBarButtonItem *item in controller.navigationItem.rightBarButtonItems ?: @[]) {
            if ([item.accessibilityIdentifier isEqualToString:@"LeadPeerInfoBarItem"]) {
                existing = item;
                continue;
            }
            [items addObject:item];
        }
        long long peerId = LeadPeerIdFromObject(controller);
        BOOL show = [[NSUserDefaults standardUserDefaults] boolForKey:kShowPeerInfo] && peerId != 0 &&
                    !LeadIsSettingsOrMyProfileObject(controller) && !LeadIsCurrentUserPeer(peerId);
        if (!show) {
            if (existing) {
                [UIView performWithoutAnimation:^{
                    controller.navigationItem.rightBarButtonItems = items;
                }];
            }
            return;
        }
        NSInteger peerNamespace = LeadPeerNamespaceFromObject(controller);
        NSString *idText = peerNamespace == 2 ? [NSString stringWithFormat:@"-100%lld", peerId]
                         : peerNamespace == 1 ? [NSString stringWithFormat:@"-%lld", peerId]
                                              : [NSString stringWithFormat:@"%lld", peerId];
        LeadPeerInfoTarget *target = existing ? objc_getAssociatedObject(existing, &LeadPeerInfoTargetKey) : nil;
        if (!target) target = [LeadPeerInfoTarget new];
        UIBarButtonItem *item = existing ?: [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"number"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:target
                                                                           action:@selector(showPeerInfo)];
        item.target = target;
        item.action = @selector(showPeerInfo);
        item.accessibilityIdentifier = @"LeadPeerInfoBarItem";
        item.accessibilityLabel = [NSString stringWithFormat:@"ID %@", idText];
        target.idText = idText;
        target.registered = (peerNamespace == 0 || peerNamespace == NSNotFound) ? LeadRegistrationEstimate(peerId) : nil;
        target.controller = controller;
        target.barItem = item;
        objc_setAssociatedObject(item, &LeadPeerInfoTargetKey, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (existing && [controller.navigationItem.rightBarButtonItems.lastObject isEqual:existing]) return;
        [items addObject:item];
        [UIView performWithoutAnimation:^{
            controller.navigationItem.rightBarButtonItems = items;
        }];
    } @catch (NSException *e) {}
}

static void LeadInstallProfileItems(UIViewController *controller) {
    LeadInstallGhostNavItem(controller);
    LeadInstallPeerInfoItem(controller);
    LeadPlaceHeaderRow(controller);
}

%hook _TtC14PeerInfoScreen18PeerInfoScreenImpl
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    LeadInstallProfileItems((UIViewController *)self);
    UIViewController *controller = (UIViewController *)self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LeadInstallProfileItems(controller);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LeadInstallProfileItems(controller);
    });
    // A big group's profile can take a while to load, and its button waits for that.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LeadInstallProfileItems(controller);
    });
}
%end

%hook _TtC10TelegramUI18ChatControllerImpl
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    @try {
        id context = [((id)self) valueForKey:@"context"];
        Class tlParser = NSClassFromString(@"TLParser");
        if ([tlParser respondsToSelector:@selector(setSharedContext:)]) {
            [tlParser performSelector:@selector(setSharedContext:) withObject:context];

            NSNumber *currId = [tlParser performSelector:@selector(getCurrentUserId)];
            if (currId) {
                [[NSUserDefaults standardUserDefaults] setInteger:[currId integerValue] forKey:@"LeadLastKnownUserId"];
            }
        }
    } @catch (NSException *e) {}
}
%end

%hook _TtC10TelegramUI22TelegramRootController
- (void)loadView {
    %orig;
    @try {
        id context = [((id)self) valueForKey:@"context"];
        Class tlParser = NSClassFromString(@"TLParser");
        if (context && [tlParser respondsToSelector:@selector(setSharedContext:)]) {
            [tlParser performSelector:@selector(setSharedContext:) withObject:context];
        }
    } @catch (NSException *e) {}
}
%end

%group CallConfirmHooks

%hook ASControlNode
- (void)sendActionsForControlEvents:(NSUInteger)controlEvents withEvent:(UIEvent *)event {
    if (controlEvents == (1 << 4)) { // ASControlNodeEventTouchUpInside
        NSString *label = [(id)self accessibilityLabel];
        if (label && label.length > 0 && [[NSUserDefaults standardUserDefaults] boolForKey:kConfirmCalls]) {
            NSString *lower = [label lowercaseString];
            
            // Fallback EN/RU labels plus whatever the active Telegram language
            // calls the profile buttons (PeerInfo.ButtonCall / ButtonVideoCall).
            NSMutableSet *callLabels = [NSMutableSet setWithArray:@[
                @"call", @"позвонить", @"звонок"
            ]];
            NSMutableSet *videoLabels = [NSMutableSet setWithArray:@[
                @"video", @"видео", @"video call", @"видеозвонок"
            ]];
            TGLocalization *loc = getActiveTGLocalization();
            NSString *localizedCall = [[loc get:@"PeerInfo.ButtonCall"] lowercaseString];
            NSString *localizedVideo = [[loc get:@"PeerInfo.ButtonVideoCall"] lowercaseString];
            if (localizedCall.length > 0 && ![localizedCall isEqualToString:@"peerinfo.buttoncall"]) [callLabels addObject:localizedCall];
            if (localizedVideo.length > 0 && ![localizedVideo isEqualToString:@"peerinfo.buttonvideocall"]) [videoLabels addObject:localizedVideo];
            
            BOOL isCall = [callLabels containsObject:lower];
            BOOL isVideo = [videoLabels containsObject:lower];
            
            if (isCall || isVideo) {
                UIWindow *window = LeadMainWindow();
                UIViewController *rootVC = window.rootViewController;
                while (rootVC.presentedViewController) {
                    rootVC = rootVC.presentedViewController;
                }
                if (rootVC) {
                    NSString *confirmTitle = isVideo ? @"Video Call" : @"Call";
                    NSString *alertTitle = isVideo ? @"Start Video Call?" : @"Start Call?";
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                   message:nil
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:nil]];
                    [alert addAction:[UIAlertAction actionWithTitle:confirmTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                        %orig(controlEvents, event);
                    }]];
                    
                    [rootVC presentViewController:alert animated:YES completion:nil];
                    return;
                }
            }
        }
    }
    %orig;
}
%end

%end // CallConfirmHooks

%group SiriBypassHooks
%hook INPreferences

+ (void)initialize {
}

+ (instancetype)sharedPreferences {
    return nil;
}

+ (instancetype)alloc {
    return nil;
}

+ (instancetype)new {
    return nil;
}

- (instancetype)init {
    return nil;
}

+ (NSInteger)siriAuthorizationStatus {
    return 0; // INSiriAuthorizationStatusNotDetermined
}

+ (void)requestSiriAuthorization:(void (^)(NSInteger status))routine {
    if (routine) {
        routine(0);
    }
}

%end
%end // SiriBypassHooks

// Stories: "Download Stories" clears the story noforwards flag and "Hide Stories"
// empties the feed — both in TLParser. StoryItemSetContainerComponent.View's
// requestSave is private Swift, so calling it from here only ever threw.

__attribute__((constructor))
static void hook() {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *bundleId = bundle.bundleIdentifier ?: @"";
    NSString *processName = [NSProcessInfo processInfo].processName ?: @"";
    NSString *executableName = bundle.executablePath.lastPathComponent ?: @"";
    NSDictionary *extensionInfo = bundle.infoDictionary[@"NSExtension"];
    NSString *extensionPoint = extensionInfo[@"NSExtensionPointIdentifier"] ?: @"";
    NSString *identity = [[NSString stringWithFormat:@"%@ %@ %@ %@", bundleId, processName, executableName, extensionPoint] lowercaseString];
    if ([identity containsString:@"notificationservice"] ||
        [identity containsString:@"notificationcontent"] ||
        [identity containsString:@"com.apple.usernotifications.service"]) {
        NSLog(@"[Lead] Skipping UI hooks inside notification extension");
        return;
    }

    NSLog(@"[Lead] Tweak initializing...");
    
    @try {
        [[NSBundle bundleWithPath:@"/System/Library/Frameworks/Intents.framework"] load];
        Class inPreferencesClass = objc_getClass("INPreferences");
        if (inPreferencesClass) {
            %init(SiriBypassHooks, INPreferences = inPreferencesClass);
            NSLog(@"[Lead] SiriBypassHooks initialized immediately");
        } else {
            NSLog(@"[Lead] SiriBypassHooks init failed: INPreferences class not found");
        }
    } @catch (NSException *e) {
        NSLog(@"[Lead] SiriBypassHooks init failed: %@", e);
    }
    
    [LeadAntiRevokeUpdater shared];
    [LeadDeletionBanner install];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
        kDisableAllAds: @NO,
        kGhostModeEnabled: @NO,
        kAntiRevoke: @NO,
        kAntiEdit: @NO,
        kAntiSelfDestruct: @NO,
        kHideStories: @NO,
        kDownloadStories: @NO,
        kDisableMessageReadReceipt: @NO,
        kDisableStoriesReadReceipt: @NO,
        kDisableOnlineStatus: @NO,
        kDisableTypingStatus: @NO,
        kDisableRecordingVideoStatus: @NO,
        kDisableUploadingVideoStatus: @NO,
        kDisableRecordingVoiceStatus: @NO,
        kDisableUploadingVoiceStatus: @NO,
        kDisableUploadingPhotoStatus: @NO,
        kDisableUploadingFileStatus: @NO,
        kDisableChoosingLocationStatus: @NO,
        kDisableChoosingContactStatus: @NO,
        kDisablePlayingGameStatus: @NO,
        kDisableRecordingRoundVideoStatus: @NO,
        kDisableUploadingRoundVideoStatus: @NO,
        kDisableSpeakingInGroupCallStatus: @NO,
        kDisableChoosingStickerStatus: @NO,
        kDisableEmojiInteractionStatus: @NO,
        kDisableEmojiAcknowledgementStatus: @NO,
        kConfirmCalls: @YES,
        kHideTTLLabel: @NO,
        kVisualStarsEnabled: @NO,
        kVisualStarsAmount: @0,
        kGhostPeerRecords: @[],
        kGhostPeerKeys: @[]
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init(
            _TtC10TelegramUI18ChatControllerImpl = objc_getClass("_TtC10TelegramUI18ChatControllerImpl")
        );

        @try {
            Class asControlNodeClass = objc_getClass("ASControlNode");
            if (asControlNodeClass) {
                %init(CallConfirmHooks, ASControlNode = asControlNodeClass);
                NSLog(@"[Lead] CallConfirmHooks initialized");
            }
        } @catch (NSException *e) {
            NSLog(@"[Lead] CallConfirmHooks init failed: %@", e);
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            showWelcomeAlertIfNeeded();
        });

    });
 }
