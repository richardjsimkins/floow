// Copyright 2019 (c) Richard J. Simkins. All rights reserved.

#import "RjsModelManager.h"

@interface RjsModelManager()
@end

@implementation RjsModelManager
	- (void) locationAppend:(CLLocation*)location {
		[self setLocationLast:location];
	}
@end
