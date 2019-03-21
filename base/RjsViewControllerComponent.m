// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsViewControllerComponent.h"

@interface RjsViewControllerComponent()
@end

@implementation RjsViewControllerComponent
	+ (UIViewController*)
		addToStackView:(UIStackView*)parentView
		andViewController:(UIViewController*)parentViewController
		withStoryboardName:(NSString*)storyboardName
		andIdentifier:(NSString*)identifier {

		UIStoryboard* storyboard = [UIStoryboard
			storyboardWithName:storyboardName
			bundle:[NSBundle mainBundle]
		];
		UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
		[parentViewController addChildViewController:viewController];
		[parentView addArrangedSubview:[viewController view]];
		[viewController didMoveToParentViewController:parentViewController];

		return viewController;
	}
/*	class func add<T:UIViewController>(
		toStackView parentView:UIStackView,
		andViewController parentViewController:UIViewController,
		withStoryboard storyboardName:String
	) -> T? {
		let storyboard = UIStoryboard(
			name:storyboardName,
			bundle:Bundle.main
		)

		guard
//			let storyboard = parentViewController.storyboard,
			let viewController = storyboard.instantiateViewController(withIdentifier:RjsId()) as? T
		else {
			return nil
		}

		parentViewController.addChild(viewController)
		parentView.addArrangedSubview(viewController.view)
		viewController.didMove(toParent:parentViewController)

		return viewController
	}*/
@end
