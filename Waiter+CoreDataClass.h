//
//  Waiter+CoreDataClass.h
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant, Shift;

NS_ASSUME_NONNULL_BEGIN

@interface Waiter : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Waiter+CoreDataProperties.h"
