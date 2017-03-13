//
//  Restaurant+CoreDataProperties.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Restaurant+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Waiter *> *staff;

@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addStaffObject:(Waiter *)value;
- (void)removeStaffObject:(Waiter *)value;
- (void)addStaff:(NSSet<Waiter *> *)values;
- (void)removeStaff:(NSSet<Waiter *> *)values;

@end

NS_ASSUME_NONNULL_END
