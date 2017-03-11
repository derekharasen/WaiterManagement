//
//  Waiter+CoreDataProperties.m
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-10.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Waiter+CoreDataProperties.h"

@implementation Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Waiter"];
}

@dynamic name;
@dynamic restaurant;
@dynamic shifts;

@end
