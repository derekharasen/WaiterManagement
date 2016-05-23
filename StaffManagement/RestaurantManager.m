//
//  RestaurantManager.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "RestaurantManager.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Restaurant.h"
#import "Shift.h"
@interface RestaurantManager()
@property (nonatomic, retain) Restaurant *restaurant;
@end

@implementation RestaurantManager
+ (id)sharedManager {
    static RestaurantManager *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
-(Restaurant*)currentRestaurant{
    if(self.restaurant == nil)
    {
        Restaurant *aRestaurant;
        NSError *error = nil;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Restaurant"];
        NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
        
        if(results.count > 0){
            aRestaurant = results[0];
        }
        else{
            NSEntityDescription *restaurantEntity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:appDelegate.managedObjectContext];
            NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
            aRestaurant = [[Restaurant alloc] initWithEntity:restaurantEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
            
            Waiter *initialWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
            initialWaiter.name = NSLocalizedString(@"John Smith", nil);
            [aRestaurant addStaffObject:initialWaiter];
            
            [appDelegate.managedObjectContext save:&error];
        }
        self.restaurant = aRestaurant;
    }
    return self.restaurant;
}
-(NSArray *)getShiftsForWaiter:(Waiter *)waiter{
  //Get app delegate instance
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *moc = appDelegate.managedObjectContext;
  
  //Fetch Request
  NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Shift entityName]];
  request.predicate = [NSPredicate predicateWithFormat:@"%K like %@",@"waiter.name", waiter.name];
  
  NSError *error = nil;
  return [moc executeFetchRequest:request error:&error];
}
-(Shift *)saveShiftToWaiter:(Waiter*)waiter
                  WithShift:(NSString *)shiftName
                  WithStart:(NSDate *)start
                    withEnd:(NSDate *)end{
  //Get app delegate instance
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *moc = appDelegate.managedObjectContext;
  
  Shift *newShift= [Shift insertNewObjectIntoContext:moc];
  newShift.name = shiftName;
  newShift.waiter = waiter;
  newShift.startTime = start;
  newShift.endTime = end;
  
  NSError *error = nil;
  if ([moc save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
  }
  
  return newShift;
}
-(BOOL)deleteShift:(Shift*)shift{
  //Get app delegate instance
  NSManagedObjectContext *moc = shift.managedObjectContext;
  
  [moc deleteObject:shift];
  
  NSError *error = nil;
  if ([moc save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
  }
  return true;
}
@end
