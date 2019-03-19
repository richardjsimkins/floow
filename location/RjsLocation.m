// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsLocation.h"

#import "RjsContainer.h"

@interface RjsLocation()
	@property (nonatomic) CLLocationManager* locationManager;
@end

@implementation RjsLocation
	// 3 metres.
	const CLLocationDistance distanceFilter = 3;

	- (instancetype)init {
		self = [super init];

		if (!self) return nil;

		[self setLocationManager:[[CLLocationManager alloc] init]];
		[[self locationManager] setAllowsBackgroundLocationUpdates:YES];
		[[self locationManager] setDelegate:self];
		[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
		[[self locationManager] setDistanceFilter:distanceFilter];
		[[self locationManager] setPausesLocationUpdatesAutomatically:NO];

		return self;
	}

	- (void)
		locationManager:(CLLocationManager*)manager
		didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

		switch (status) {
		case kCLAuthorizationStatusDenied:
		case kCLAuthorizationStatusRestricted:
		case kCLAuthorizationStatusAuthorizedWhenInUse:
			NSLog(@"AuthorizationStatus: Denied");
			[RjsContainer containerSetWithIdentifier:@"PermissionLocationDenied"];
			break;
		// Shouldn't reappear after initial setup.
		case kCLAuthorizationStatusNotDetermined:
			NSLog(@"AuthorizationStatus: kCLAuthorizationStatusNotDetermined");
			break;
		case kCLAuthorizationStatusAuthorizedAlways:
			NSLog(@"AuthorizationStatus: Authorized");
			[RjsContainer containerSetWithIdentifier:@"PermissionLocationAuthorized"];
			[[self locationManager] startUpdatingLocation];
			break;
		}
	}

	- (void)
		locationManager:(CLLocationManager*)manager
		didFailWithError:(NSError*)error {
	}

	- (void)
		locationManager:(CLLocationManager*)manager
		didFinishDeferredUpdatesWithError:(NSError*)error {
	}

	- (void) locationManagerDidPauseLocationUpdates:(CLLocationManager*)manager {
	}

	- (void) locationManagerDidResumeLocationUpdates:(CLLocationManager*)manager {
	}

	- (void)
		locationManager:(CLLocationManager*)manager
		didUpdateLocations:(NSArray<CLLocation*>*)locations {

		CLLocation* location = [locations lastObject];
		NSLog(@"%f;%f;%f edu=%f ts=%ld", [location coordinate].longitude, [location coordinate].latitude, [location altitude], [manager distanceFilter], time(0));
	}

	- (void) start {
		[[self locationManager] requestAlwaysAuthorization];
	}
@end
