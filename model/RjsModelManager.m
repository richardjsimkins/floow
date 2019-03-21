// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsModelManager.h"

@interface RjsModelManager()
@end

@implementation RjsModelManager
	- (void) locationAppend:(CLLocation*)location {
		NSData* data = [NSKeyedArchiver
			archivedDataWithRootObject:location
			requiringSecureCoding:NO
			error:nil];
		[[NSUserDefaults standardUserDefaults]
			setObject:data
			forKey:@"key-location-last"];

		if ([self trackingEnabled]) {
			[self trackingAppendLocationDataToLatestRecord:data];
		}
	}

	+ (CLLocation*) locationFromData:(NSData*)data {
		return (CLLocation*)[NSKeyedUnarchiver
			unarchivedObjectOfClass:[CLLocation class]
			fromData:data
			error:nil];
	}

	- (CLLocation*) locationLast {
		[[NSUserDefaults standardUserDefaults] synchronize];

		NSData* data = [[NSUserDefaults standardUserDefaults] dataForKey:@"key-location-last"];

		if (!data) return nil;

		return [RjsModelManager locationFromData:data];

	}

	- (MKPolyline*) polylineFromTrackingLast {
		NSArray* trackingCollection = [self trackingCollectionLoad];

		if ([trackingCollection count] == 0) return nil;

		NSArray* locationCollection = [trackingCollection lastObject];

		if ([locationCollection count] == 0) return nil;

		CLLocationCoordinate2D coordinateCollection[[locationCollection count]];
		uint coordinateCollectionCount = 0;

		for (NSData* data in locationCollection) {
			CLLocation* location = (CLLocation*)[NSKeyedUnarchiver
				unarchivedObjectOfClass:[CLLocation class]
				fromData:data
				error:nil];
			coordinateCollection[coordinateCollectionCount] = location.coordinate;
			coordinateCollectionCount++;
		}

		return [MKPolyline
			polylineWithCoordinates:coordinateCollection
			count:coordinateCollectionCount];
	}

	- (void) trackingAppendLocationDataToLatestRecord:(NSData*)data {
		NSMutableArray* trackingCollection = [[self trackingCollectionLoad] mutableCopy];

		if ([trackingCollection count] == 0) {
			[trackingCollection addObject:[[NSMutableArray alloc] init]];
		}

		NSMutableArray* locationCollection = [[trackingCollection lastObject] mutableCopy];
		[locationCollection addObject:data];
		[trackingCollection
			replaceObjectAtIndex:[trackingCollection count] - 1
			withObject:locationCollection];
		NSURL* documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
		[trackingCollection
			writeToURL:[documentPath URLByAppendingPathComponent:@"tracking-collection.plist"]
			error:nil];
	}

	- (void) trackingBeginNewRecord {
		NSMutableArray* trackingCollection = [[self trackingCollectionLoad] mutableCopy];

		// Create the initial record for the tracking collection.
		// Or create a new record if the existing record is populated i.e. if the existing record is
		// empty it is already a "new" record.
		if (
			[trackingCollection count] == 0
			|| [[trackingCollection lastObject] count] > 0
		) {
			[trackingCollection addObject:[[NSMutableArray alloc] init]];
			NSURL* documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
			[trackingCollection
				writeToURL:[documentPath URLByAppendingPathComponent:@"tracking-collection.plist"]
				error:nil];
		}

		// Since location events will only get added as the user's location changes we need to
		// add the last location to begin the record.
		[self locationAppend:[self locationLast]];
	}

	- (NSArray*) trackingCollectionLoad {
		NSURL* documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
		NSArray* trackingCollection = [[NSArray alloc]
			initWithContentsOfURL:[documentPath URLByAppendingPathComponent:@"tracking-collection.plist"]
			error:nil];

		if (!trackingCollection) return [[NSArray alloc] init];

		return trackingCollection;
	}

	- (BOOL) trackingEnabled {
		[[NSUserDefaults standardUserDefaults] synchronize];

		return [[NSUserDefaults standardUserDefaults] boolForKey:@"key-tracking-enabled"];
	}

	- (void) trackingOff {
		[[NSUserDefaults standardUserDefaults]
			setBool:NO
			forKey:@"key-tracking-enabled"];
	}

	- (void) trackingSwitch {
		[[NSUserDefaults standardUserDefaults] synchronize];
		bool trackingEnabledCurrent = [[NSUserDefaults standardUserDefaults] boolForKey:@"key-tracking-enabled"];
		[[NSUserDefaults standardUserDefaults]
			setBool:!trackingEnabledCurrent
			forKey:@"key-tracking-enabled"];

		// We've just turned on tracking. Begin a new tracking record.
		if (trackingEnabledCurrent == NO) {
			[self trackingBeginNewRecord];
		}
	}
@end
