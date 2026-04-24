#import <UIKit/UIKit.h>
#import "Headers.h"

@interface ASDisplayNode : NSObject
@property (atomic, assign, readonly) UIView *view;
@property (atomic, copy, readonly) NSArray *subnodes;
@property (atomic, copy, readwrite) NSString *accessibilityLabel;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
- (void)__handleSettingsTabLongPress:(UILongPressGestureRecognizer *)gesture;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
@end

static __weak TGLocalization *TGLocalizationShared = nil;

%hook TGLocalization

- (id)initWithVersion:(int)a code:(id)b dict:(id)c isActive:(BOOL)d {
    TGLocalization *instance = %orig;
    if (a != 96929692 && instance) {
        TGLocalizationShared = instance;
    }
    return instance;
}

%end

void showUI() {
	Lead *ui = [Lead new];
	UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:ui];

	UIWindow *window = UIApplication.sharedApplication.keyWindow;
	UIViewController *rootVC = window.rootViewController;
	if (rootVC) {
	    [rootVC presentViewController:navVC animated:YES completion:nil];
	}
}

// ============================================================
// Settings Long-Press — only way to open Lead menu
// Long-press the "Telegram Features" row in Settings → opens menu
// ============================================================

%hook ASDisplayNode
%property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

%new
- (void)__handleSettingsTabLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
		showUI();
    }
}

%end

%hook PeerInfoScreenItemNode

- (void)didEnterHierarchy {
    %orig;

    ASDisplayNode *mainNode = self;

	if (!mainNode.longPressGesture) {
		mainNode.longPressGesture = [[UILongPressGestureRecognizer alloc]
		    initWithTarget:mainNode
		            action:@selector(__handleSettingsTabLongPress:)];
	}

    for (ASDisplayNode *child in mainNode.subnodes) {
        if ([NSStringFromClass([child class]) isEqualToString:@"Display.AccessibilityAreaNode"]) {
            
            // By default, the button is "Ask a Question"
            NSString *localizedTitle = @"Ask a Question";
            
            // Try to get the actual localized version from Telegram
            if (TGLocalizationShared) {
                NSString *resultTitle = [TGLocalizationShared get:@"Settings.Support"];
                if (resultTitle.length > 0 && ![resultTitle isEqualToString:@"Settings.Support"]) {
                    localizedTitle = resultTitle;
                }
            }

            // We match against either the exact localized title or the English default
            BOOL isTarget = [child.accessibilityLabel isEqualToString:localizedTitle] || 
                            [child.accessibilityLabel isEqualToString:@"Ask a Question"];

            if (isTarget) {
                if (![mainNode.view.gestureRecognizers containsObject:mainNode.longPressGesture]) {
                    [mainNode.view addGestureRecognizer:mainNode.longPressGesture];
                }
            }
        }
    }
}

%end

// ============================================================
// First-launch welcome alert.
// Shows once when Lead is injected for the first time.
// On iPhone, UIAlertControllerStyleAlert CANNOT be dismissed by
// tapping outside — iOS prevents it natively. The alert stays
// visible until the user taps one of the buttons.
// • "Join Channel →" → opens https://t.me/Leedgram, saves flag, closes alert
// • "OK"             → closes alert, saves flag — never shows again
// ============================================================
static void showWelcomeAlertIfNeeded() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"LeadWelcomeShown"]) return;

    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    UIViewController *rootVC = window.rootViewController;
    if (!rootVC) return;

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"Lead"
        message:@"Lead has been successfully injected into Telegram.\n\nTo open the tweak menu: long-press the \"Ask a Question\" row in the Settings tab."
        preferredStyle:UIAlertControllerStyleAlert];

    // Helper block — saves flag so alert never shows again
    void (^markShown)(void) = ^{
        [defaults setBool:YES forKey:@"LeadWelcomeShown"];
        [defaults synchronize];
    };

    // "Join Channel" — opens the developer's Telegram channel and dismisses alert
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

    // "OK" — closes the alert, never shows again
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
    if ([NSStringFromClass([root class]) containsString:prefix]) {
        return root;
    }
    if ([root respondsToSelector:@selector(subnodes)]) {
        for (ASDisplayNode *child in root.subnodes) {
            ASDisplayNode *found = findNodeByClassNamePrefix(child, prefix);
            if (found) return found;
        }
    }
    return nil;
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
    });
    return instance;
}
- (void)handleDeleted:(NSNotification *)note {
    NSArray *deletedIds = note.userInfo[@"ids"];
    if (!deletedIds || deletedIds.count == 0) return;
    
    // We must run on main thread, but the notification is already dispatched to main thread.
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

// Hook ASDisplayNode globally to catch lazily loaded message nodes.
%hook ASDisplayNode

- (void)layout {
    %orig;
    
    NSString *className = NSStringFromClass([self class]);
    if (![className containsString:@"ChatMessage"] || ![className containsString:@"ItemNode"]) {
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
    BOOL isDeletedMsg = (msgId && [TLParser isDeleted:msgId]);
    
    ASDisplayNode *node = (ASDisplayNode *)self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isDeletedMsg) {
            // Background color highlight removed as requested
            // node.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.1];
            
            UIImageView *trashIcon = nil;
            for (UIView *v in node.view.subviews) {
                if (v.tag == 8898) {
                    trashIcon = (UIImageView *)v;
                    break;
                }
            }
            
            BOOL isNewlyCreated = NO;
            if (!trashIcon) {
                trashIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"trash.fill"]];
                trashIcon.tintColor = [UIColor systemRedColor];
                trashIcon.tag = 8898;
                [node.view addSubview:trashIcon];
                isNewlyCreated = YES;
            }
            
            ASDisplayNode *statusNode = findNodeByClassNamePrefix(node, @"ChatMessageDateAndStatusNode");
            if (statusNode && statusNode.view) {
                CGRect statusFrame = [node.view convertRect:statusNode.view.bounds fromView:statusNode.view];
                // Place to the left of the time
                trashIcon.frame = CGRectMake(statusFrame.origin.x - 18, statusFrame.origin.y + (statusFrame.size.height / 2.0) - 7, 14, 14);
                trashIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            } else {
                // Fallback to bottom right if status node isn't found
                trashIcon.frame = CGRectMake(node.view.bounds.size.width - 40, node.view.bounds.size.height - 35, 20, 20);
                trashIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
            }
            
            BOOL wasHidden = trashIcon.hidden;
            trashIcon.hidden = NO;
            [node.view bringSubviewToFront:trashIcon];
            
            // Play a nice spring "pop" animation if it just appeared (either created now, or un-hidden)
            if (wasHidden || isNewlyCreated) {
                trashIcon.transform = CGAffineTransformMakeScale(0.1, 0.1);
                trashIcon.alpha = 0.0;
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    trashIcon.transform = CGAffineTransformIdentity;
                    trashIcon.alpha = 1.0;
                } completion:nil];
            }
            
        } else {
            node.view.backgroundColor = [UIColor clearColor];
            for (UIView *v in node.view.subviews) {
                if (v.tag == 8898) {
                    v.hidden = YES;
                }
            }
        }
    });
}
%end

__attribute__((constructor))
static void hook() {
    [LeadAntiRevokeUpdater shared];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	 	%init(
            PeerInfoScreenItemNode = objc_getClass("PeerInfoScreen.PeerInfoScreenItemNode")
		);

        // Show welcome alert after the app UI has fully loaded
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            showWelcomeAlertIfNeeded();
        });
	});
}
