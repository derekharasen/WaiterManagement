//
//  Shift.m
//  StaffManagement
//
//  Created by Karlo Pagtakhan on 05/20/2016.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import "Shift.h"
#import "Waiter.h"

@implementation Shift

@dynamic name;
@dynamic startTime;
@dynamic endTime;
@dynamic waiter;

// Insert code here to add functionality to your managed object subclass
+ (NSString *)entityName{
  return @"Shift";
}
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context{
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                       inManagedObjectContext:context];
}
@end
