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
@interface RestaurantManager()
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic) NSMutableArray *waiterNames;
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
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        self.managedContext = appDelegate.managedObjectContext;
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
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Waiter"];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:YES];
    [request setPropertiesToFetch: @[@"name"]];
    
    self.waiterNames = [NSMutableArray new];
    for (Waiter *waiter in self.restaurant.staff) {
        [self.waiterNames addObject:waiter.name];
    }
    return self.restaurant;
}

#pragma mark - Core Data Functions

-(Waiter*)newWaiter:(NSString*)name{
    NSError *error = nil;
    for (NSString *waiterName in self.waiterNames) {
        if ([waiterName isEqualToString:name]){
            return nil;
        }
    }
    
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    Waiter *waiter = [[Waiter alloc] initWithEntity:waiterEntity insertIntoManagedObjectContext:self.managedContext];
    waiter.name = name;
    
    [self.restaurant addStaffObject:waiter];
    if(![self.managedContext save:&error]){
        NSLog(@"error: %@",error.localizedDescription);
        return nil;
    }
    
    [self.waiterNames addObject:name];
    return waiter;
}

-(BOOL)removeShift:(Shift*)shift{
    NSError *error = nil;
    
    if (self.selected != nil){
        [self.selected removeShiftsObject:shift];
        [self.managedContext deleteObject:shift];
        if (![self.managedContext save:&error]){
            NSLog(@"Error ! %@", error.localizedDescription);
            return false;
        }
        return true;
    }
    return false;
}

-(Waiter*)removeWaiter:(NSString*)name{
    Waiter *waiter = [self getWaiter:name];
    NSError *error = nil;
    
    if (waiter != nil){
        [self.managedContext deleteObject:waiter];
        [self.waiterNames removeObject:name];
        if (![self.managedContext save:&error]){
            NSLog(@"Error ! %@", error.localizedDescription);
            return nil;
        }
    }
    
    return waiter;
}

-(Waiter*)getWaiter:(NSString*)name{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error.localizedDescription);
        return nil;
    }
    
    if (fetchedObjects.count > 0){
        return fetchedObjects[0];
    }
    return nil;
}

@end
