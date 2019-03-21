// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <UIKit/UIKit.h>

#import "RjsViewControllerComponent.h"

@interface RjsTrackingEventRecord : RjsViewControllerComponent
	@property (nonatomic, weak) IBOutlet UILabel* label;
	@property (nonatomic) NSArray* locationCollection;
@end
