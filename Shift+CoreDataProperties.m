//
//  Shift+CoreDataProperties.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Shift+CoreDataProperties.h"

@implementation Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic date;
@dynamic startTime;
@dynamic endTime;
@dynamic waiter;

@end
