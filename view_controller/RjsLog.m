// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsLog.h"

#import "RjsModelManager.h"
#import "RjsTrackingEventRecord.h"
#import "UIViewController+Rjs.h"

@interface RjsLog()
	@property (nonatomic) RjsModelManager* modelManager;
	@property (nonatomic, weak) IBOutlet UIStackView* stackView;
@end

@implementation RjsLog
	- (void) viewDidLoad {
		[self setModelManager:[[RjsModelManager alloc] init]];
	}

	- (void) viewWillAppear:(BOOL)animated {
		for (UIViewController* viewController in [self childViewControllers]) {
			[viewController removeViewAndSelfFromParentViewController];
		}

		NSArray* trackingCollection = [[self modelManager] trackingCollectionLoad];
		uint trackingCollectionCount = 0;

		for (NSArray* locationCollection in trackingCollection) {
			if (trackingCollectionCount == [trackingCollection count]) continue;

			RjsTrackingEventRecord* trackingEventRecord = (RjsTrackingEventRecord*) [self
				addViewControllerFromStoryboardName:@"Main"
				withIdentifier:@"TrackingEventRecord"
				toParentStackView:[self stackView]];
			[[trackingEventRecord label] setText:[NSString stringWithFormat:@"Tracking event record %u", trackingCollectionCount]];
			[trackingEventRecord setLocationCollection:locationCollection];
			trackingCollectionCount++;
		}
	}
@end
