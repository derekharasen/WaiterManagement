//
//  AddShiftViewController.swift
//  StaffManagement
//
//  Created by Stephen Gilroy on 2016-06-12.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit

class AddShiftViewController: UIViewController {
    
    var waiter: Waiter!

    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Functions
    @IBAction func addButton(sender: UIButton) {
        
        //Add new shift to Core Data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Shift", inManagedObjectContext: managedContext)
        
        let newShift = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let startDate: NSDate = startDatePicker.date
        let endDate: NSDate = endDatePicker.date
        
        newShift.setValue(self.waiter, forKey: "waiter")
        newShift.setValue(startDate, forKey: "start")
        newShift.setValue(endDate, forKey: "end")
        
        //Save context
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        //Dismiss to previous view
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Dismiss to previous view
    @IBAction func backButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
