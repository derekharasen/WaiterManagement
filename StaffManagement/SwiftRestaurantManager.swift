//
//  SwiftRestaurantManager.swift
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class SwiftRestaurantManager: NSObject {
    
    static let sharedManager: SwiftRestaurantManager = {
        let instance = SwiftRestaurantManager()
        return instance
    }()
    
    var selected: Waiter?
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var restaurant: Restaurant?
    var waiterNames = [String]()
    
    func currentRestaurant() -> Restaurant{
        if (restaurant == nil){
            var aRestaurant = Restaurant()
            var results = [Restaurant]()
            let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Restaurant")
            
            do{
                results = try managedContext?.fetch(request) as! [Restaurant]
            }
            catch{
                print("Error")
            }
            
            if (results.count > 0){
                aRestaurant = results[0]
            }
            else {
                let restaurantEntity = NSEntityDescription.entity(forEntityName: "Restaurant", in: managedContext!)
                let waiterEntity = NSEntityDescription.entity(forEntityName: "Waiter", in: managedContext!)
                aRestaurant = Restaurant.init(entity: restaurantEntity!, insertInto: managedContext!)
                let initialWaiter = Waiter.init(entity: waiterEntity!, insertInto: managedContext!)
                initialWaiter.name = "John Smith"
                aRestaurant.addStaffObject(initialWaiter)
                try? managedContext?.save()
            }
            restaurant = aRestaurant
        }
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Waiter")
        request.resultType = .dictionaryResultType
        request.returnsDistinctResults = true
        request.propertiesToFetch = ["name"]
        
        for waiter in (restaurant?.staff)! {
            let waiterName = waiter as! Waiter
            waiterNames.append(waiterName.name)
        }
        return restaurant!
    }
    
    func newWaiter(name: String) -> Waiter?{
        for waiterName in waiterNames {
            if (waiterName == name){
                return nil
            }
        }
        let waiterEntity = NSEntityDescription.entity(forEntityName: "Waiter", in: managedContext!)
        let waiter = Waiter.init(entity: waiterEntity!, insertInto: managedContext!)
        waiter.name = name
        waiter.restaurant = restaurant!
        
        restaurant?.addStaffObject(waiter)
        
        do{
            try managedContext?.save()
        }
        catch{
            return nil
        }
        waiterNames.append(name)
        return waiter
    }
    //    -(BOOL)removeShift:(Shift*)shift{
    //    NSError *error = nil;
    //
    //    if (self.selected != nil){
    //    [self.selected removeShiftsObject:shift];
    //    [self.managedContext deleteObject:shift];
    //    if (![self.managedContext save:&error]){
    //    NSLog(@"Error ! %@", error.localizedDescription);
    //    return false;
    //    }
    //    return true;
    //    }
    //    return false;
    //    }
    //
    //    -(Waiter*)removeWaiter:(NSString*)name{
    //    Waiter *waiter = [self getWaiter:name];
    //    NSError *error = nil;
    //
    //    if (waiter != nil){
    //    [self.managedContext deleteObject:waiter];
    //    [self.waiterNames removeObject:name];
    //    if (![self.managedContext save:&error]){
    //    NSLog(@"Error ! %@", error.localizedDescription);
    //    return nil;
    //    }
    //    }
    //
    //    return waiter;
    //    }
    //
    //    -(Waiter*)getWaiter:(NSString*)name{
    //    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:self.managedContext];
    //    [fetchRequest setEntity:entity];
    //
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    //    [fetchRequest setPredicate:predicate];
    //    NSError *error = nil;
    //    NSArray *fetchedObjects = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    //    
    //    if (fetchedObjects == nil) {
    //    NSLog(@"error: %@", error.localizedDescription);
    //    return nil;
    //    }
    //    
    //    if (fetchedObjects.count > 0){
    //    return fetchedObjects[0];
    //    }
    //    return nil;
    //    }
    
    
}
