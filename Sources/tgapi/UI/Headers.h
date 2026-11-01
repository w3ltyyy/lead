#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <roothide.h>
#import "../Constants.h"

@interface Lead : UIViewController <UITableViewDataSource, UITableViewDelegate>
// Presents the menu (in its own navigation controller) over the topmost screen.
+ (void)presentMenu;
@end

@interface TGLocalization : NSObject
- (NSString *)get:(NSString *)queryString;
- (id)initWithVersion:(int)a code:(id)b dict:(id)c isActive:(BOOL)d;
@end

@interface LeadLocalization  : NSObject
@property (nonatomic, strong ) TGLocalization *localization;
+ (instancetype)shared;
+ (NSString *)localizedStringForKey:(NSString *)key;
@end

// Returns the path to Lead.bundle regardless of installation method.
// Works on jailbreak, SwiftGram, AltStore, and any sideloaded IPA.
// Both LeadLocalization and LanguageSelector must use this function.
NSString *LeadBundlePath(void);


@interface LanguageSelector : UIViewController <UITableViewDataSource, UITableViewDelegate>
@end

@interface DonateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@end


@interface LocationSelector : UIViewController <MKMapViewDelegate>
@end

#ifdef __cplusplus
extern "C" {
#endif
NSString *LeadPeerKey(NSString *kind, long long peerId);
NSArray<NSString *> *LeadGhostAliasesForRawPeerId(long long rawPeerId);
BOOL LeadIsGhostPeerEnabledForKeys(NSArray<NSString *> *keys);
BOOL LeadIsGhostPeerEnabledForRawPeerId(long long rawPeerId);
void LeadSetGhostPeerEnabled(NSString *primaryKey, NSArray<NSString *> *aliases,
                             NSString *title, BOOL enabled);
NSArray<NSDictionary *> *LeadGhostPeerRecords(void);
void LeadRemoveGhostPeer(NSString *primaryKey);
#ifdef __cplusplus
}
#endif
