//
//  ShiftManager.swift
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-10-02.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import Foundation
import CoreData

class ShiftManager : NSObject {
    
    func saveShift(startTime:NSDate, endTime:NSDate) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entity(forEntityName: "Shift",
                                                in: managedContext)
        let shift = NSManagedObject(entity: entity!,
                                    insertInto:managedContext)
        //set start and end times on 'shift' entity
        shift.setValue(startTime, forKey: "startTime")
        shift.setValue(endTime, forKey: "endTime")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func updateShiftList() -> [NSManagedObject] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let request: NSFetchRequest<NSFetchRequestResult> = Shift.fetchRequest() as! NSFetchRequest<NSFetchRequestResult>

        do {
            let results =
                try managedContext.fetch(request)
            
            //return array of shifts
            return results as! [NSManagedObject];
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            abort()
        }
        
    }
}
