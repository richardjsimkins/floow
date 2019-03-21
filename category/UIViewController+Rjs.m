// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "AppDelegate.h"
#import "UIViewController+Rjs.h"

@implementation UIViewController(Rjs)
	- (UIViewController*)
		addViewControllerFromStoryboardName:(NSString*)storyboardName
		withIdentifier:(NSString*)identifier
		toParentStackView:(UIStackView*)parentStackView {
/*	+ (UIViewController*)
		addToStackView:(UIStackView*)parentView
		andViewController:(UIViewController*)parentViewController
		withStoryboardName:(NSString*)storyboardName
		andIdentifier:(NSString*)identifier {*/

		UIStoryboard* storyboard = [UIStoryboard
			storyboardWithName:storyboardName
			bundle:[NSBundle mainBundle]
		];
		UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
		[self addChildViewController:viewController];
		[parentStackView addArrangedSubview:[viewController view]];
		[viewController didMoveToParentViewController:self];

		return viewController;
	}

	// o Recursively find the first UIViewController that matches the passed in class out of the
	//   collection of the rootViewcontroller's childViewControllers.
	+ (UIViewController*) childOfClass:(Class)class {
		UIWindow* window = [[AppDelegate Instance] window];

		if (!window) return nil;

		UIViewController* rootViewController = [window rootViewController];

		if (!rootViewController) return nil;

		return [rootViewController childOfClass:class];
	}

	// o Recursively find the first UIViewController that matches the passed in class out of the
	//   collection of this instance's childViewControllers.
	- (UIViewController*) childOfClass:(Class)class {
		if ([self isKindOfClass:class]) return self;

		for (UIViewController* childViewController in [self childViewControllers]) {
			UIViewController* childViewControllerOfMatchingClass = [childViewController childOfClass:class];

			if (childViewControllerOfMatchingClass) return childViewControllerOfMatchingClass;
		}

		return nil;
	}

	- (void) removeViewAndSelfFromParentViewController {
		[self willMoveToParentViewController:nil];
		[[self view] removeFromSuperview];
		[self removeFromParentViewController];
	}
@end
