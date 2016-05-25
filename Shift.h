//
//  Shift.h
//  StaffManagement
//
//  Created by Karlo Pagtakhan on 05/20/2016.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Waiter;

@interface Shift : NSManagedObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, retain) Waiter *waiter;

+(NSString *)entityName;
+(instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context;
@end

