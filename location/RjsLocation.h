// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <CoreLocation/CoreLocation.h>

@interface RjsLocation:NSObject<CLLocationManagerDelegate>
	- (void) powersaveOff;
	- (void) powersaveOn;
	- (void) requestPermission;
	- (void) start;
	- (void) stop;
@end
