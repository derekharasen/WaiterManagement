//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
@class Waiter;

@interface RestaurantManager : NSObject
+ (id)sharedManager;
-(Restaurant*)currentRestaurant;
-(Waiter*)saveWaiter:(NSString*)name;
-(Waiter*)removeWaiter:(Waiter*)waiter;
@end
