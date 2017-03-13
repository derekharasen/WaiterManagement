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
    
    func removeShift(shift: Shift) -> Bool{
        guard selected != nil else{
            return false
        }
        selected?.removeShiftsObject(shift)
        managedContext?.delete(shift)
        do{
            try managedContext?.save()
        }
        catch{
          return false
        }
        return true
    }

    func removeWaiter(name: String) -> Waiter?{
        let waiter = getWaiter(name: name)
        
        guard (waiter != nil) else {
            return nil
        }
        
        managedContext?.delete(waiter!)
        if let index = waiterNames.index(of:name) {
            waiterNames.remove(at: index)
        }
        
        do{
            try managedContext?.save()
        }
        catch{
            return nil
        }
    
        return waiter
    }
    
    func getWaiter(name: String) -> Waiter?{
        var fetchedObjects = [Waiter]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: "Waiter", in: managedContext!)
        fetchRequest.entity = entity
        
        let predicate = NSPredicate.init(format: "name", name)
        fetchRequest.predicate = predicate
        
        do{
            fetchedObjects = try managedContext?.fetch(fetchRequest) as! [Waiter]
        }
        catch{
            return nil
        }
        
        guard (fetchedObjects.count > 0) else{
            return nil
        }
        
        return fetchedObjects[0]
    }
}
