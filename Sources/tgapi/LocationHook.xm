#import "Headers.h"
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import<MapKit/MapKit.h>

bool shouldFakeLocation() {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FAKE_LOCATION_ENABLED_KEY];
}

@interface TGExtraFakeLocationManager : NSObject
@property (nonatomic, strong) NSHashTable<CLLocationManager *> *locationManagers;
@property (nonatomic, strong) NSTimer *lieToDelegateTimer;
+ (instancetype)shared;
@end

@implementation TGExtraFakeLocationManager

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
	static TGExtraFakeLocationManager *instance;
	dispatch_once(&token, ^{
		instance = [[TGExtraFakeLocationManager alloc] init];
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
	CGFloat savedLongitude = [defaults floatForKey:FAKE_LONGITUDE_KEY];
	CGFloat savedLatitude = [defaults floatForKey:FAKE_LATITUDE_KEY];
	
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
		
		CGFloat savedLongitude = [defaults floatForKey:FAKE_LONGITUDE_KEY];
        CGFloat savedLatitude = [defaults floatForKey:FAKE_LATITUDE_KEY];
        
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
		CGFloat savedLongitude = [defaults floatForKey:FAKE_LONGITUDE_KEY];
        CGFloat savedLatitude = [defaults floatForKey:FAKE_LATITUDE_KEY];
        
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
    if (self) {
        [[TGExtraFakeLocationManager shared].locationManagers addObject:self];
    }
    return self;
}

- (void)setDelegate:(id)delegate {
	//customLog(@"Set Delegate :%@", delegate);
    %orig;
	
    [[TGExtraFakeLocationManager shared].locationManagers addObject:self];
}

%end

@interface MKCoreLocationProvider : NSObject
- (id)_clLocationManager;
@end

%hook MKCoreLocationProvider

- (id)initWithCLLocationManager:(id)locationManager {
    if ([locationManager isKindOfClass:[CLLocationManager class]]) {
        [[TGExtraFakeLocationManager shared].locationManagers addObject:(CLLocationManager *)locationManager];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CLLocationManager *innerLocationManager = [self _clLocationManager];
		[[TGExtraFakeLocationManager shared].locationManagers addObject:innerLocationManager];
    });

    return %orig;
}

%end


__attribute__((constructor))
static void initLocationHooks() {
	 %init(
	    DeviceLocationManager = objc_getClass("DeviceLocationManager.DeviceLocationManager")
	);
	
	[TGExtraFakeLocationManager shared];
}
