// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <MapKit/MapKit.h>

#import "RjsModelManager.h"
#import "RjsTrack.h"

@interface RjsTrack()
	@property (nonatomic, weak) IBOutlet UILabel* buttonLabel;
	@property (nonatomic, weak) IBOutlet MKMapView* map;
	@property (nonatomic) RjsModelManager* modelManager;
	@property (nonatomic) NSTimer* timer;
@end

@implementation RjsTrack
	const CLLocationDistance oneKilometre = 1000;
	const NSTimeInterval tenSeconds = 10;

	- (void) buttonLabelUpdate {
		[[self buttonLabel] setText:
			[[self modelManager] trackingEnabled]
				? @"Turn tracking off"
				: @"Turn tracking on"];
	}

	- (IBAction) tap:(id)sender {
		[[self modelManager] trackingSwitch];
		[self buttonLabelUpdate];
	}

	- (void) viewDidLoad {
		[self setModelManager:[[RjsModelManager alloc] init]];
	}

	- (void) viewWillAppear:(BOOL)animated {
		[self buttonLabelUpdate];

		[self setTimer:[NSTimer
			scheduledTimerWithTimeInterval:tenSeconds
			repeats:YES
			block:^(NSTimer* _Nonnull timer) {
				CLLocation* location = [[self modelManager] locationLast];

				if (!location) return;

				[[self map]
					setCenterCoordinate:[location coordinate]
					animated:YES];
				MKCoordinateRegion region = [[self map] regionThatFits:MKCoordinateRegionMakeWithDistance([location coordinate], oneKilometre, oneKilometre)];
				[[self map]
					setRegion:region
					animated:YES];
			}
		]];
	}
@end
