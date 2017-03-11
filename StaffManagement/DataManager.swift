//
//  DataManager.swift
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-10.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let sharedInstance = DataManager()
    private override init() {}
    
    func generateWaiter() -> Waiter {
        let waiter = NSEntityDescription.insertNewObject(forEntityName: "Waiter", into: appDelegate.managedObjectContext) as! Waiter
        return waiter
    }
    
    func generateShift() -> Shift {
        let shift = NSEntityDescription.insertNewObject(forEntityName: "Shift", into: appDelegate.managedObjectContext) as! Shift
        return shift
    }
    
    func saveContext() {
        appDelegate.saveContext()
    }
}
