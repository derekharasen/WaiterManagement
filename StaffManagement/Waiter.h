//
//  Waiter.h
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Shift.h"

NS_ASSUME_NONNULL_BEGIN

@class Restaurant;

@interface Waiter : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nullable, nonatomic, retain) NSSet<Shift *> *shifts;

@end



@interface Waiter (CoreDataGeneratedAccessors)

- (void)addShiftsObject:(Shift *)value;
- (void)removeShiftsObject:(Shift *)value;
- (void)addShifts:(NSSet<Shift *> *)values;
- (void)removeShifts:(NSSet<Shift *> *)values;

@end

NS_ASSUME_NONNULL_END









