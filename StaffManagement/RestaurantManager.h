//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant+CoreDataProperties.h"
#import "AppDelegate.h"

@interface RestaurantManager : NSObject

@property (nonatomic) AppDelegate *appDelegate;

+ (id)sharedManager;
-(Restaurant*)currentRestaurant;

@end
