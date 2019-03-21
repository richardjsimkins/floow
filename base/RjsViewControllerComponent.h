// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <UIKit/UIKit.h>

@interface RjsViewControllerComponent : UIViewController
	+ (UIViewController*)
		addToStackView:(UIStackView*)parentView
		andViewController:(UIViewController*)parentViewController
		withStoryboardName:(NSString*)storyboardName
		andIdentifier:(NSString*)identifier;
@end
