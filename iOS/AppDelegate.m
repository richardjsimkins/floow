// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "AppDelegate.h"

#import "RjsLocation.h"
#import "RjsModelManager.h"

@interface AppDelegate()
	@property (nonatomic) RjsLocation* location;
	@property (nonatomic) RjsModelManager* modelManager;
@end

@implementation AppDelegate
	- (BOOL)
		application:(UIApplication*)application
		didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {

		[self setLocation:[[RjsLocation alloc] init]];

		return YES;
	}

	- (void) applicationWillResignActive:(UIApplication*)application {
		if ([[self modelManager] trackingEnabled]) {
			[[self location] powersaveOn];
		} else {
			[[self location] stop];
		}
	}

	- (void) applicationDidBecomeActive:(UIApplication*)application {
		// When the app first loads we don't want to alter the location state since we need to get
		// past the onboarding of asking for permissions first.
		if ([self modelManager]) {
			if ([[self modelManager] trackingEnabled]) {
				[[self location] powersaveOff];
			} else {
				[[self location] start];
			}
		} else {
			[self setModelManager:[[RjsModelManager alloc] init]];
			// Ensure we don't continue user tracking between app executions.
			[[self modelManager] trackingOff];
		}
	}

	+ (AppDelegate*) Instance {
		return (AppDelegate*) [[UIApplication sharedApplication] delegate];
	}

	- (void) locationRequestPermission {
		[[self location] requestPermission];
	}
@end
