// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "AppDelegate.h"

#import "RjsLocation.h"
#import "RjsModelManager.h"

@interface AppDelegate()
	@property (nonatomic) RjsLocation* location;
@end

@implementation AppDelegate
	- (BOOL)
		application:(UIApplication*)application
		didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {

		[self setLocation:[[RjsLocation alloc] init]];
		RjsModelManager* modelManager = [[RjsModelManager alloc] init];
		// Ensure we don't continue user tracking between app executions.
		[modelManager trackingOff];

		return YES;
	}

	+ (AppDelegate*) Instance {
		return (AppDelegate*) [[UIApplication sharedApplication] delegate];
	}

	- (void) locationStart {
		[[self location] start];
	}
@end
