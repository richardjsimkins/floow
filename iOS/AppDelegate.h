// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "RjsModelManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
	@property (nonatomic) RjsModelManager* modelManager;
	@property (nonatomic) UIWindow* window;

	+ (AppDelegate*) Instance;
	- (void) locationStart;
@end
