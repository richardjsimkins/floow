// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsLocation.h"

#import "RjsContainer.h"
#import "RjsModelManager.h"

@interface RjsLocation()
	@property (nonatomic) CLLocationManager* locationManager;
	@property (nonatomic) RjsModelManager* modelManager;
@end

@implementation RjsLocation
	const CLLocationDistance distanceFilterLow = 3;
	const CLLocationDistance distanceFilterHigh = 10;

	- (instancetype)init {
		self = [super init];

		if (!self) return nil;

		[self setLocationManager:[[CLLocationManager alloc] init]];
		[[self locationManager] setAllowsBackgroundLocationUpdates:YES];
		[[self locationManager] setDelegate:self];
		[[self locationManager] setPausesLocationUpdatesAutomatically:NO];
		[self powersaveOff];

		[self setModelManager:[[RjsModelManager alloc] init]];

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
		[[self modelManager] locationAppend:location];
		[[NSNotificationCenter defaultCenter]
			postNotificationName:@"LocationUpdate"
			object:nil];
	}

	- (void) powersaveOff {
		[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
		[[self locationManager] setDistanceFilter:distanceFilterHigh];
	}

	- (void) powersaveOn {
		[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
		[[self locationManager] setDistanceFilter:distanceFilterLow];
	}

	- (void) requestPermission {
		[[self locationManager] requestAlwaysAuthorization];
	}

	- (void) start {
		if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) return;

		[[self locationManager] startUpdatingLocation];
	}

	- (void) stop {
		[[self locationManager] stopUpdatingLocation];
	}
@end
