#import <UIKit/UIKit.h>
#import "Headers.h"

@interface ASDisplayNode : NSObject
@property (atomic, assign, readonly) UIView *view;
@property (atomic, copy, readonly) NSArray *subnodes;
@property (atomic, copy, readwrite) NSString *accessibilityLabel;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
- (void)__handleSettingsTabLongPress:(UILongPressGestureRecognizer *)gesture;
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
			NSString *localizedTitle = @"Telegram Features";

			NSString *resultTitle = [TGLocalizationShared get:@"Settings.Support"];
			if (resultTitle.length > 0 && ![resultTitle isEqualToString:@"Settings.Support"]) {
				localizedTitle = resultTitle;
			}

            if ([child.accessibilityLabel isEqualToString:localizedTitle]) {
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
        alertControllerWithTitle:@"Lead ✓"
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

// Helper to find a subview by class name substring
static UIView *findViewByClassNamePrefix(UIView *root, NSString *prefix) {
    if ([NSStringFromClass([root class]) containsString:prefix]) {
        return root;
    }
    for (UIView *subview in root.subviews) {
        UIView *found = findViewByClassNamePrefix(subview, prefix);
        if (found) return found;
    }
    return nil;
}

// Hook ASDisplayNode globally to catch lazily loaded message nodes.
%hook ASDisplayNode

- (void)layout {
    %orig;
    
    NSString *className = NSStringFromClass([self class]);
    if (![className containsString:@"ChatMessage"] || ![className containsString:@"ItemNode"]) {
        return;
    }
    
    NSNumber *msgId = [TLParser getMessageIdFromNode:self];
    BOOL isDeletedMsg = (msgId && [TLParser isDeleted:msgId]);
    
    ASDisplayNode *node = (ASDisplayNode *)self;
    dispatch_async(dispatch_get_main_queue(), ^{
        // DEBUG: Always add a label to see if the hook runs and what the ID is.
        UILabel *debugLabel = nil;
        for (UIView *v in node.view.subviews) {
            if (v.tag == 8899) {
                debugLabel = (UILabel *)v;
                break;
            }
        }
        
        if (!debugLabel) {
            debugLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
            debugLabel.backgroundColor = [UIColor yellowColor];
            debugLabel.textColor = [UIColor blackColor];
            debugLabel.font = [UIFont systemFontOfSize:10];
            debugLabel.tag = 8899;
            [node.view addSubview:debugLabel];
        }
        
        debugLabel.text = [NSString stringWithFormat:@"ID: %@ | Cls: %@", msgId ? msgId : @"nil", className];
        [node.view bringSubviewToFront:debugLabel];
        debugLabel.hidden = NO;
        
        if (isDeletedMsg) {
            debugLabel.backgroundColor = [UIColor redColor];
            debugLabel.text = [debugLabel.text stringByAppendingString:@" (DELETED)"];
            
            UIImageView *trashIcon = nil;
            for (UIView *v in node.view.subviews) {
                if (v.tag == 8898) {
                    trashIcon = (UIImageView *)v;
                    break;
                }
            }
            
            if (!trashIcon) {
                trashIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"trash.fill"]];
                trashIcon.tintColor = [UIColor redColor];
                trashIcon.tag = 8898;
                trashIcon.alpha = 0.8;
                [node.view addSubview:trashIcon];
            }
            
            UIView *statusView = findViewByClassNamePrefix(node.view, @"ChatMessageDateAndStatusNode");
            if (statusView) {
                CGRect statusFrame = [node.view convertRect:statusView.bounds fromView:statusView];
                trashIcon.frame = CGRectMake(statusFrame.origin.x + statusFrame.size.width + 2, statusFrame.origin.y + (statusFrame.size.height / 2.0) - 7, 14, 14);
                trashIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            } else {
                trashIcon.frame = CGRectMake(node.view.bounds.size.width / 2.0, 30, 14, 14);
            }
            
            trashIcon.hidden = NO;
            [node.view bringSubviewToFront:trashIcon];
        } else {
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
