// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <CoreLocation/CoreLocation.h>

@interface RjsModelManager : NSObject
	- (void) locationAppend:(CLLocation*)location;
	- (CLLocation*) locationLast;
	- (BOOL) trackingEnabled;
	- (void) trackingSwitch;
@end
