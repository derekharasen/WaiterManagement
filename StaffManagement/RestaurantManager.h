//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "Waiter.h"
@interface RestaurantManager : NSObject
+ (id)sharedManager;
-(Restaurant*)currentRestaurant;
-(void)addShiftWithDate:(NSString *)date start:(NSString *)start end:(NSString *)end forWaiter:(Waiter *)waiter;
- (void)deleteShift:(Shift *)shift;
@end
