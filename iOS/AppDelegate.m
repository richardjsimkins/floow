// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "AppDelegate.h"

@interface AppDelegate()
@end

@implementation AppDelegate
	+ (AppDelegate*) Instance {
		return (AppDelegate*) [[UIApplication sharedApplication] delegate];
	}
@end
