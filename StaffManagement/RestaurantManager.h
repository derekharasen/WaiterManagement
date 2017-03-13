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
@class Shift;

@interface RestaurantManager : NSObject
+ (id)sharedManager;
@property Waiter *selected;
@property (nonatomic) NSManagedObjectContext *managedContext;
-(Restaurant*)currentRestaurant;
-(Waiter*)newWaiter:(NSString*)name;
-(Waiter*)removeWaiter:(NSString*)name;
-(Waiter*)getWaiter:(NSString*)name;
-(BOOL)removeShift:(Shift*)shift;
@end
