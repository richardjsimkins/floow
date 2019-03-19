// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsContainer.h"

#import <CoreLocation/CoreLocation.h>

@interface RjsContainer()
@end

@implementation RjsContainer
	- (void) viewDidLoad {
		switch ([CLLocationManager authorizationStatus]) {
		case kCLAuthorizationStatusRestricted:
		case kCLAuthorizationStatusDenied:
			[RjsContainer containerSetWithIdentifier:@"PermissionLocationDenied"];
			break;
		case kCLAuthorizationStatusAuthorizedAlways:
			[RjsContainer containerSetWithIdentifier:@"PermissionLocationAuthorized"];
			break;
		default:
			[RjsContainer containerSetWithIdentifier:@"PermissionLocationNotDetermined"];
		}
	}
@end
