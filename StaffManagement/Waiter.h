//
//  Waiter.h
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant, Shift;

@interface Waiter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) NSSet *shifts;
@end

@interface Waiter (CoreDataGeneratedAccessors)

- (void)addShiftsObject:(Shift *)value;
- (void)removeShiftsObject:(Shift *)value;
- (void)addShifts:(NSSet *)values;
- (void)removeShifts:(NSSet *)values;

@end
