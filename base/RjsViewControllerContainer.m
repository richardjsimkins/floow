// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsViewControllerContainer.h"

#import "UIViewController+Rjs.h"

@interface RjsViewControllerContainer()
	@property (nonatomic) UIViewController* containerViewController;
@end

@implementation RjsViewControllerContainer
	- (void) containerAddWithIdentifier:(NSString*)identifier {
		if (![self storyboard]) return;

		// This will throw an exception if the identifier does not exist in the storyboard. Since
		// there is no way to check for an indentifier we allow the method to throw its exception as
		// a development time issue.
		UIViewController* viewController = [[self storyboard] instantiateViewControllerWithIdentifier:identifier];

		if ([self containerViewController]) {
			[self containerRemoveWithViewController:[self containerViewController]];
		}

		[self setContainerViewController:viewController];
		[self addChildViewController:viewController];
		[[viewController view] setFrame:CGRectMake(
			0,
			0,
			[[self view] frame].size.width,
			[[self view] frame].size.height)];
		[[self view] addSubview:[viewController view]];
		[viewController didMoveToParentViewController:self];
	}

	- (void) containerRemoveWithViewController:(UIViewController*)viewController {
		[viewController willMoveToParentViewController:nil];
		[[viewController view] removeFromSuperview];
		[viewController removeFromParentViewController];
	}

	// Needs to be a class function so external classes can change the viewController in the
	// container.
	+ (void) containerSetWithIdentifier:(NSString*)identifier {
		RjsViewControllerContainer* viewControllerContainer = (RjsViewControllerContainer*) [UIViewController childOfClass:self];

		// An instance of RjsViewControllerConatiner could not be found on the UIWindow
		// viewController stack.
		if (!viewControllerContainer) return;

		[viewControllerContainer containerAddWithIdentifier:identifier];
	}
@end
