//
//  Waiter+CoreDataProperties.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Waiter+CoreDataProperties.h"

@implementation Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Waiter"];
}

@dynamic name;
@dynamic restaurant;
@dynamic shift;

@end
