#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <roothide.h>
#import "../Constants.h"

@interface Lead : UIViewController <UITableViewDataSource, UITableViewDelegate>
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

@interface LocationSelector : UIViewController <MKMapViewDelegate>
@end

