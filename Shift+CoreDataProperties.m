//
//  Shift+CoreDataProperties.m
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Shift+CoreDataProperties.h"

@implementation Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic endTime;
@dynamic startTime;
@dynamic waiter;

@end
