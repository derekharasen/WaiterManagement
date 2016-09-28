//
//  Waiter+CoreDataProperties.h
//  StaffManagement
//
//  Created by Carl Udren on 9/10/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Waiter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Waiter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Restaurant *restaurant;
@property (nullable, nonatomic, retain) NSSet<Shift *> *shift;

@end

@interface Waiter (CoreDataGeneratedAccessors)

- (void)addShiftObject:(Shift *)value;
- (void)removeShiftObject:(Shift *)value;
- (void)addShift:(NSSet<Shift *> *)values;
- (void)removeShift:(NSSet<Shift *> *)values;

@end

NS_ASSUME_NONNULL_END
