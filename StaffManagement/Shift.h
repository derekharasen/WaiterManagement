//
//  Shift.h
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Waiter;

@interface Shift : NSManagedObject

@property (nullable, nonatomic, copy) NSDate *end;
@property (nullable, nonatomic, copy) NSDate *start;
@property (nullable, nonatomic, retain) Waiter *waiter;

@end
