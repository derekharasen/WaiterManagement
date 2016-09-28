//
//  Restaurant+CoreDataProperties.h
//  StaffManagement
//
//  Created by Carl Udren on 9/10/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Restaurant.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Waiter *> *staff;

@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addStaffObject:(Waiter *)value;
- (void)removeStaffObject:(Waiter *)value;
- (void)addStaff:(NSSet<Waiter *> *)values;
- (void)removeStaff:(NSSet<Waiter *> *)values;

@end

NS_ASSUME_NONNULL_END
