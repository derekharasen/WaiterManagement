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
@property (nonatomic) NSManagedObjectContext *managedContext;
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

-(BOOL)saveWaiter:(NSString*)name{
    NSError *error = nil;
    for (NSString *waiterName in self.waiterNames) {
        if ([waiterName isEqualToString:name]){
            return false;
        }
    }
    
    Waiter *waiter = [[Waiter alloc] initWithContext:self.managedContext];
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    waiter = [[Waiter alloc] initWithEntity:waiterEntity insertIntoManagedObjectContext:self.managedContext];
    waiter.name = name;
    waiter.restaurant = self.restaurant;
    
    if(![self.managedContext save:&error]){
        NSLog(@"error: %@",error.localizedDescription);
        return false;
    }
    return true;
}

-(BOOL)removeWaiter:(Waiter*)waiter{
    NSString *name = waiter.name;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error.localizedDescription);
        return false;
    }
    if (fetchedObjects.count > 0){
        [self.managedContext deleteObject:waiter];
        return true;
    }
    return false;
}

@end
