//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant+CoreDataProperties.h"
#import "AppDelegate.h"

@interface RestaurantManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (id)sharedManager;
-(Restaurant*)currentRestaurant;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)getContext;

@end
