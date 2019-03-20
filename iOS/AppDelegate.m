// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "AppDelegate.h"

#import "RjsLocation.h"

@interface AppDelegate()
	@property (nonatomic) RjsLocation* location;
@end

@implementation AppDelegate
	- (BOOL)
		application:(UIApplication*)application
		didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {

		[self setLocation:[[RjsLocation alloc] init]];

		return YES;
	}

	+ (AppDelegate*) Instance {
		return (AppDelegate*) [[UIApplication sharedApplication] delegate];
	}

	- (void) locationStart {
		[[self location] start];
	}
@end
