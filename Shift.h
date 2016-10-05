//
//  Shift+CoreDataProperties.h
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-10-02.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Waiter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shift: NSManagedObject

+ (NSFetchRequest<Shift *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nullable, nonatomic, retain) Waiter *waiter;

@end

NS_ASSUME_NONNULL_END
