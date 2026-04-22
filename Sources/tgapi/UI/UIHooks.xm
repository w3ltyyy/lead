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
// • "Join Channel" → opens https://t.me/Leedgram
// • "OK"           → dismisses and never shows again
// ============================================================
static void showWelcomeAlertIfNeeded() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"LeadWelcomeShown"]) return;

    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    UIViewController *rootVC = window.rootViewController;
    if (!rootVC) return;

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"Lead ✓"
        message:@"Lead has been successfully injected into Telegram.\n\nTo open the tweak menu: long-press the \"Telegram Features\" row in the Settings tab."
        preferredStyle:UIAlertControllerStyleAlert];

    // "Join Channel" — top action, opens the developer's Telegram channel
    UIAlertAction *channelAction = [UIAlertAction
        actionWithTitle:@"Join Channel →"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:@"https://t.me/Leedgram"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }];

    // "OK" — closes the alert and marks it as shown so it never appears again
    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:@"OK"
                  style:UIAlertActionStyleCancel
                handler:^(UIAlertAction *action) {
        [defaults setBool:YES forKey:@"LeadWelcomeShown"];
        [defaults synchronize];
    }];

    [alert addAction:channelAction];
    [alert addAction:okAction];

    [rootVC presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor))
static void hook() {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	 	%init(
            PeerInfoScreenItemNode = objc_getClass("PeerInfoScreen.PeerInfoScreenItemNode")
		);

        // Show welcome alert after the app UI has fully loaded
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            showWelcomeAlertIfNeeded();
        });
	});
}
