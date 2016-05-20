//
//  Restaurant.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant

@dynamic name;
@dynamic staff;

+ (NSString *)entityName{
  return @"Restaurant";
}
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context{
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                       inManagedObjectContext:context];
}
@end
