// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIViewController(Rjs)
	- (UIViewController*)
			addViewControllerFromStoryboardName:(NSString*)storyboardName
			withIdentifier:(NSString*)identifier
			toParentStackView:(UIStackView*)parentStackView;
	+ (UIViewController*) childOfClass:(Class)class;
	- (UIViewController*) childOfClass:(Class)class;
	- (void) removeViewAndSelfFromParentViewController;
@end
