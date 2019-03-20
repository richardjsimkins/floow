// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsModelManager.h"

@interface RjsModelManager()
@end

@implementation RjsModelManager
	- (void) locationAppend:(CLLocation*)location {
		NSData* data = [NSKeyedArchiver
			archivedDataWithRootObject:location
			requiringSecureCoding:NO
			error:nil];
		[[NSUserDefaults standardUserDefaults]
			setObject:data
			forKey:@"key-location-last"];
	}

	- (CLLocation*) locationLast {
		[[NSUserDefaults standardUserDefaults] synchronize];

		NSData* data = [[NSUserDefaults standardUserDefaults] dataForKey:@"key-location-last"];

		if (!data) return nil;

		return (CLLocation*)[NSKeyedUnarchiver
			unarchivedObjectOfClass:[CLLocation class]
			fromData:data
			error:nil];

	}

	- (BOOL) trackingEnabled {
		[[NSUserDefaults standardUserDefaults] synchronize];

		return [[NSUserDefaults standardUserDefaults] boolForKey:@"key-tracking-enabled"];
	}

	- (void) trackingSwitch {
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[NSUserDefaults standardUserDefaults]
			setBool:![[NSUserDefaults standardUserDefaults] boolForKey:@"key-tracking-enabled"]
			forKey:@"key-tracking-enabled"];
	}
@end
