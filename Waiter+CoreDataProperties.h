//
//  Waiter+CoreDataProperties.h
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Waiter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Restaurant *restaurant;
@property (nullable, nonatomic, retain) NSSet<Shift *> *shifts;

@end

@interface Waiter (CoreDataGeneratedAccessors)

- (void)addShiftsObject:(Shift *)value;
- (void)removeShiftsObject:(Shift *)value;
- (void)addShifts:(NSSet<Shift *> *)values;
- (void)removeShifts:(NSSet<Shift *> *)values;

@end

NS_ASSUME_NONNULL_END
