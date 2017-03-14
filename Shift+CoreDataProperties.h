//
//  Shift+CoreDataProperties.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Shift+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, retain) Waiter *waiter;

@end

NS_ASSUME_NONNULL_END
