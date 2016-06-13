//
//  Shift+CoreDataProperties.h
//  StaffManagement
//
//  Created by Stephen Gilroy on 2016-06-13.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Shift.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shift (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *start;
@property (nullable, nonatomic, retain) NSDate *end;
@property (nullable, nonatomic, retain) Waiter *waiter;

@end

NS_ASSUME_NONNULL_END
