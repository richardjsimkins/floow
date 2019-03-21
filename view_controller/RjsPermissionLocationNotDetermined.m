// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsPermissionLocationNotDetermined.h"

#import "AppDelegate.h"

@interface RjsPermissionLocationNotDetermined()
@end

@implementation RjsPermissionLocationNotDetermined
	- (IBAction) tap:(id)sender {
		[[AppDelegate Instance] locationRequestPermission];
	}

	- (void) viewWillAppear:(BOOL)animated {
	}
@end
