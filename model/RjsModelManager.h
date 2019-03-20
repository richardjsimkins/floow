// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RjsModelManager : NSObject
	- (void) locationAppend:(CLLocation*)location;
	- (CLLocation*) locationLast;
	- (MKPolyline*) polylineFromTrackingLast;
	- (BOOL) trackingEnabled;
	- (void) trackingOff;
	- (void) trackingSwitch;
@end
