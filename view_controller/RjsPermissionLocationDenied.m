// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsPermissionLocationDenied.h"

@interface RjsPermissionLocationDenied()
@end

@implementation RjsPermissionLocationDenied
	- (IBAction) tap:(id)sender {
		[[UIApplication sharedApplication]
			openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
			options:@{}
			completionHandler:nil];
	}
@end
