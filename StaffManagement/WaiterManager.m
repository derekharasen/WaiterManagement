//
//  NSObject+WaiterManager.m
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-09-30.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//



#import "WaiterManager.h"
#import "AppDelegate.h"
#import "Waiter.h"

@interface WaiterManager ()
@property Waiter *waiter;
@end

@implementation WaiterManager


-(void)saveWaiter:(NSString*)name {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedContext = appDelegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:managedContext];
    
    NSManagedObject *waiter = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedContext];
    
    [waiter setValue:name forKey:@"name"];
    
    NSError *error = nil;
    if (![managedContext save:&error]) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

-(void)deleteWaiter:(NSManagedObject*)waiter {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedContext = appDelegate.managedObjectContext;
    
    // Delete object from database
    [managedContext deleteObject:waiter];
    //Save new context and check for errors
    NSError *error = nil;
    if (![managedContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

-(NSMutableArray*)updateWaiterList {
    // Fetch the waiters from persistent data store
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Waiter"];
    NSError *error = nil;
    NSArray *results = [managedContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Error fetching Waiter objects: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    NSMutableArray<NSManagedObject*> *waiters = [NSMutableArray arrayWithArray:results];
    return waiters;
}



@end
