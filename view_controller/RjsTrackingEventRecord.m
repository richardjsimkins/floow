// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsTrackingEventRecord.h"

#import "RjsModelManager.h"

@interface RjsTrackingEventRecord()
@end

@implementation RjsTrackingEventRecord
	- (IBAction) tap:(id)sender {
		NSString* timeEnd = @"unknown";
		NSString* timeStart = @"unknown";

		if ([[self locationCollection] count] > 0) {
			NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
			CLLocation* locationStart = [RjsModelManager locationFromData:[[self locationCollection] firstObject]];
			timeStart = [dateFormatter stringFromDate:[locationStart timestamp]];
			CLLocation* locationEnd = [RjsModelManager locationFromData:[[self locationCollection] lastObject]];
			timeEnd = [dateFormatter stringFromDate:[locationEnd timestamp]];
		}

		UIAlertController* alertController = [UIAlertController
			alertControllerWithTitle:@"Tracking details"
			message:[NSString stringWithFormat:@"Your journey started at %@ and ended at %@.", timeStart, timeEnd]
			preferredStyle:UIAlertControllerStyleAlert];
		[alertController addAction:[UIAlertAction
			actionWithTitle:@"OK"
			style:UIAlertActionStyleDefault
			handler:nil]];
		[self
			presentViewController:alertController
			animated:NO
			completion:nil];
	}
@end
