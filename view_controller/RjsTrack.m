// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsModelManager.h"
#import "RjsTrack.h"

@interface RjsTrack()
	@property (nonatomic, weak) IBOutlet UILabel* buttonLabel;
	@property (nonatomic, weak) IBOutlet MKMapView* map;
	@property (nonatomic) RjsModelManager* modelManager;
@end

@implementation RjsTrack
	const CLLocationDistance oneKilometre = 1000;
	const double trackingPolylineRegionMinimum = 3000;
	const double trackingPolylineRegionPadding = 100;
	const NSTimeInterval mapUpdateDelay = 3;

	- (void) buttonLabelUpdate {
		[[self buttonLabel] setText:
			[[self modelManager] trackingEnabled]
				? @"Turn tracking off"
				: @"Turn tracking on"];
	}

	- (void) locationUpdate:(NSNotification*)notification {
		CLLocation* location = [[self modelManager] locationLast];

		if (!location) return;

		[[self map] removeOverlays:[[self map] overlays]];

		if ([[self modelManager] trackingEnabled]) {
			MKPolyline* polyline = [[self modelManager] polylineFromTrackingLast];

			if (polyline) {
				[[self map]
					addOverlay:polyline
					level:MKOverlayLevelAboveRoads];
				MKMapRect polylineRegion = [polyline boundingMapRect];

				// The polyline region may have either zero width or height if it is a
				// straight line. We only wish to correct if neither side meets the minimum
				// size.
				if (!(
					polylineRegion.size.height >= trackingPolylineRegionMinimum
					|| polylineRegion.size.width >= trackingPolylineRegionMinimum
				)) {
					polylineRegion.origin.x -= (trackingPolylineRegionMinimum - polylineRegion.size.width) / 2.0;
					polylineRegion.origin.y -= (trackingPolylineRegionMinimum - polylineRegion.size.height) / 2.0;
					polylineRegion.size.height = trackingPolylineRegionMinimum;
					polylineRegion.size.width = trackingPolylineRegionMinimum;
				}

				[[self map]
					setVisibleMapRect:polylineRegion
					edgePadding:UIEdgeInsetsMake(trackingPolylineRegionPadding, trackingPolylineRegionPadding, trackingPolylineRegionPadding, trackingPolylineRegionPadding)
					animated:YES];
			}
		} else {
			[[self map]
				setCenterCoordinate:[location coordinate]
				animated:YES];
			MKCoordinateRegion region = [[self map] regionThatFits:MKCoordinateRegionMakeWithDistance([location coordinate], oneKilometre, oneKilometre)];
			[[self map]
				setRegion:region
				animated:YES];
		}
	}

	- (MKOverlayRenderer*)
		mapView:(MKMapView*)mapView
		rendererForOverlay:(id<MKOverlay>)overlay {

		if ([overlay isKindOfClass:[MKPolyline class]]) {
			MKPolyline* polyline = overlay;
			MKPolylineRenderer* polylineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyline];
			[polylineRenderer setStrokeColor:[UIColor blackColor]];

			return polylineRenderer;
		}

		return nil;
	}

	- (IBAction) tap:(id)sender {
		[[self modelManager] trackingSwitch];
		[self buttonLabelUpdate];
		[self locationUpdate:nil];
	}

	- (void) viewDidLoad {
		[self setModelManager:[[RjsModelManager alloc] init]];
		[[self map] setDelegate:self];
	}

	- (void) viewWillAppear:(BOOL)animated {
		[self buttonLabelUpdate];

		[[NSNotificationCenter defaultCenter]
			addObserver:self
			selector:@selector(locationUpdate:)
			name:@"LocationUpdate"
			object:nil];
	}

	- (void) viewWillDisappear:(BOOL)animated {
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:@"LocationUpdate"
			object:nil];
	}
@end
