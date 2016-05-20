//
//  Waiter.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "Waiter.h"
#import "Restaurant.h"


@implementation Waiter

@dynamic name;
@dynamic restaurant;

+ (NSString *)entityName{
  return @"Waiter";
}
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context{
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                       inManagedObjectContext:context];
}
@end
