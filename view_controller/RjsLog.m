// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsLog.h"

#import "RjsTrackingEventRecord.h"

@interface RjsLog()
	@property (nonatomic, weak) IBOutlet UIStackView* stackView;
@end

@implementation RjsLog
	- (void) viewDidLoad {
		for (int i = 0; i < 20; i++) {
		[RjsTrackingEventRecord
			addToStackView:[self stackView]
			andViewController:self
			withStoryboardName:@"Main"
			andIdentifier:@"TrackingEventRecord"];
		}
	}
@end
