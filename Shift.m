//
//  Shift+CoreDataProperties.m
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-10-02.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import "Waiter.h"
#import "Shift.h"

@implementation Shift

+ (NSFetchRequest<Shift *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic startTime;
@dynamic endTime;
@dynamic waiter;

@end
