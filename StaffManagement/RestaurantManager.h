//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
@class Shift;
@class Waiter;
@interface RestaurantManager : NSObject
+ (id)sharedManager;
-(Restaurant*)currentRestaurant;
-(Shift *)saveShiftToWaiter:(Waiter*)waiter
                  WithShift:(NSString *)shiftName
                  WithStart:(NSDate *)start
                    withEnd:(NSDate *)end;
-(BOOL)deleteShift:(Shift*)shift;
-(NSArray<Shift *> *)getShiftsForWaiter:(Waiter *)waiter;
@end
