//
//  Waiter+CoreDataProperties.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Waiter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
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
