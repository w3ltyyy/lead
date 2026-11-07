#import "Headers.h"
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import<MapKit/MapKit.h>

static BOOL LeadIsNotificationExtensionProcess(void) {
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *bundleId = bundle.bundleIdentifier ?: @"";
	NSString *processName = [NSProcessInfo processInfo].processName ?: @"";
	NSString *executableName = bundle.executablePath.lastPathComponent ?: @"";
	NSDictionary *extensionInfo = bundle.infoDictionary[@"NSExtension"];
	NSString *extensionPoint = extensionInfo[@"NSExtensionPointIdentifier"] ?: @"";
	NSString *identity = [[NSString stringWithFormat:@"%@ %@ %@ %@", bundleId, processName, executableName, extensionPoint] lowercaseString];
	return [identity containsString:@"notificationservice"] ||
	       [identity containsString:@"notificationcontent"] ||
	       [identity containsString:@"com.apple.usernotifications.service"];
}

bool shouldFakeLocation() {
	if (LeadIsNotificationExtensionProcess()) return false;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FAKE_LOCATION_ENABLED_KEY];
}

@interface LeadFakeLocationManager : NSObject
@property (nonatomic, strong) NSHashTable<CLLocationManager *> *locationManagers;
@property (nonatomic, strong) NSTimer *lieToDelegateTimer;
+ (instancetype)shared;
@end

@implementation LeadFakeLocationManager

- (instancetype)init {
	self = [super init];
	if (self) {
		self.locationManagers = [NSHashTable weakObjectsHashTable];
		
		[self setupTimer];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(appDidEnterBackground)
                                             name:UIApplicationDidEnterBackgroundNotification
                                           object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
		                                         selector:@selector(appDidBecomeActive)
		                                             name:UIApplicationDidBecomeActiveNotification
		                                           object:nil];
	}
	return self;
}

+ (instancetype)shared {
	static dispatch_once_t token;
	static LeadFakeLocationManager *instance;
	dispatch_once(&token, ^{
		instance = [[LeadFakeLocationManager alloc] init];
	});
	return instance;
}

- (void)setupTimer {
	
	if (self.lieToDelegateTimer) return; 
	__weak typeof(self) weakSelf = self;
	
	self.lieToDelegateTimer = [NSTimer scheduledTimerWithTimeInterval:20
                               repeats:YES
                               block:^(NSTimer * _Nonnull timer) {
		[weakSelf lieToDelegates];
	}];
}

- (void)lieToDelegates {
	if (!shouldFakeLocation()) return;
		
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	CGFloat savedLongitude = [defaults doubleForKey:FAKE_LONGITUDE_KEY];
	CGFloat savedLatitude = [defaults doubleForKey:FAKE_LATITUDE_KEY];
	
	if (!savedLongitude || !savedLatitude) {
		return;
	}
	
	CLLocation *fakeLocation = [[CLLocation alloc] initWithLatitude:savedLatitude longitude:savedLongitude];
	NSArray *fakeLocations = @[fakeLocation];
	
    for (CLLocationManager *manager in self.locationManagers) {
		if (!manager) continue;
		id<CLLocationManagerDelegate> delegate = manager.delegate;
		if (!delegate) continue;
		if ([delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            [delegate locationManager:manager didUpdateLocations:fakeLocations];
        }
    }
}

- (void)appDidEnterBackground {
	[self.lieToDelegateTimer invalidate];
	self.lieToDelegateTimer = nil;
}

- (void)appDidBecomeActive {
	[self setupTimer];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

%hook DeviceLocationManager

- (void)locationManager:(id)manager  didUpdateLocations:(id)locations {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (shouldFakeLocation()) {
		
		CGFloat savedLongitude = [defaults doubleForKey:FAKE_LONGITUDE_KEY];
        CGFloat savedLatitude = [defaults doubleForKey:FAKE_LATITUDE_KEY];
        
		if (savedLongitude && savedLatitude) {
            CLLocation *fakeLocation = [[CLLocation alloc] initWithLatitude:savedLatitude longitude:savedLongitude];
            NSArray *fakeLocations = @[fakeLocation];
			%orig(manager, fakeLocations);
            return;
        }
	}
	%orig;
}

%end

%hook MKCoreLocationProvider

- (void)locationManager:(id)manager  didUpdateLocations:(id)locations {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (shouldFakeLocation()) {
		
		// Get Our Saved Location
		CGFloat savedLongitude = [defaults doubleForKey:FAKE_LONGITUDE_KEY];
        CGFloat savedLatitude = [defaults doubleForKey:FAKE_LATITUDE_KEY];
        
		if (savedLongitude && savedLatitude) {
            CLLocation *fakeLocation = [[CLLocation alloc] initWithLatitude:savedLatitude longitude:savedLongitude];
            NSArray *fakeLocations = @[fakeLocation];
			%orig(manager, fakeLocations);
            return;
        }
	}
	%orig;
}

%end

%hook CLLocationManager

- (id)init {
    self = %orig;
    if (self && !LeadIsNotificationExtensionProcess()) {
        [[LeadFakeLocationManager shared].locationManagers addObject:self];
    }
    return self;
}

- (void)setDelegate:(id)delegate {
	//customLog(@"Set Delegate :%@", delegate);
    %orig;
	
    if (!LeadIsNotificationExtensionProcess()) {
        [[LeadFakeLocationManager shared].locationManagers addObject:self];
    }
}

%end

@interface MKCoreLocationProvider : NSObject
- (id)_clLocationManager;
@end

%hook MKCoreLocationProvider

- (id)initWithCLLocationManager:(id)locationManager {
    if (!LeadIsNotificationExtensionProcess() && [locationManager isKindOfClass:[CLLocationManager class]]) {
        [[LeadFakeLocationManager shared].locationManagers addObject:(CLLocationManager *)locationManager];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (LeadIsNotificationExtensionProcess()) return;
        CLLocationManager *innerLocationManager = [self _clLocationManager];
		[[LeadFakeLocationManager shared].locationManagers addObject:innerLocationManager];
    });

    return %orig;
}

%end


__attribute__((constructor))
static void initLocationHooks() {
	 if (LeadIsNotificationExtensionProcess()) return;

	 %init(
	    DeviceLocationManager = objc_getClass("DeviceLocationManager.DeviceLocationManager")
	);
	
	[LeadFakeLocationManager shared];
}
