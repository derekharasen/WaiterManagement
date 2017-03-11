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
    return self.restaurant;
}

#pragma mark - Core Data Functions

-(void)saveWaiter:(NSString*)name{
    NSManagedObject *waiter = [NSEntityDescription insertNewObjectForEntityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    [waiter setValue:name forKey:@"name"];
    [waiter setValue:self.restaurant forKey:@"restaurant"];
    
    NSError *error = nil;
    if(![self.managedContext save:&error]){
        NSLog(@"error: %@",error.localizedDescription);
    }
}

-(void)removeWaiter:(NSString*)name{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

@end
