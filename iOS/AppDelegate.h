// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
	@property (nonatomic) UIWindow* window;

	+ (AppDelegate*) Instance;
	- (void) locationRequestPermission;
@end
