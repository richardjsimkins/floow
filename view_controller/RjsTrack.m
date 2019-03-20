// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <MapKit/MapKit.h>

#import "AppDelegate.h"
#import "RjsTrack.h"

@interface RjsTrack()
	@property (nonatomic, weak) IBOutlet MKMapView* map;
	@property (nonatomic) NSTimer* timer;
@end

@implementation RjsTrack
	const CLLocationDistance oneKilometre = 1000;
	const NSTimeInterval tenSeconds = 10;

	- (void) viewWillAppear:(BOOL)animated {
		[self setTimer:[NSTimer
			scheduledTimerWithTimeInterval:tenSeconds
			repeats:YES
			block:^(NSTimer* _Nonnull timer) {
				CLLocation* location = [[[AppDelegate Instance] modelManager] locationLast];

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
