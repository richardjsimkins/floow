// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIViewController(Rjs)
	+ (UIViewController*) childOfClass:(Class)class;
	- (UIViewController*) childOfClass:(Class)class;
@end
