// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import <CoreLocation/CoreLocation.h>

@interface RjsModelManager : NSObject
	@property (nonatomic) CLLocation* locationLast;

	- (void) locationAppend:(CLLocation*)location;
@end
