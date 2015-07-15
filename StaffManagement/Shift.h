//
//  Shift.h
//  StaffManagement
//
//  Created by Kunwardeep Gill on 2015-07-15.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Waiter;

@interface Shift : NSManagedObject

@property (retain, nonatomic) NSString *startDate;
@property (retain, nonatomic) NSString *endDate;
@property (retain, nonatomic) Waiter *waiter;

@end