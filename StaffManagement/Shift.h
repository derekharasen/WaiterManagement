//
//  Shift.h
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-18.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Waiter;

@interface Shift : NSManagedObject

@property (nonatomic, retain) NSString * start;
@property (nonatomic, retain) NSString * end;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Waiter *waiter;

@end
