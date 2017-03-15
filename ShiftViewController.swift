//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-14.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftViewController: UIViewController {
    
    //    class RestaurantManager {
    //        static let sharedInstance: RestaurantManager = {
    //            let instance = RestaurantManager()
    //            return instance
    //        }()
    //    }
    
    var shift: Shift?
    var waiter = Waiter()
    let manager = RestaurantManager.sharedManager()
    
    @IBOutlet weak var chooseDate: UIDatePicker!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var finishTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "Set Up Swift"
        if let shiftEdit = shift {
            chooseDate.date = shiftEdit.date!
            startTime.date = shiftEdit.startTime!
            finishTime.date = shiftEdit.endTime!
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveShift(_ sender: UIBarButtonItem) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        if let existingShift = shift {
            existingShift.date = chooseDate.date
            existingShift.startTime = startTime.date
            existingShift.endTime = finishTime.date
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Waiter", in: managedObjectContext)
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Waiter")
            fetch.setValue(entity, forKey: "Waiter")
        
        let newShift:Shift = NSEntityDescription.insertNewObject(forEntityName: "Shift", into:delegate.managedObjectContext) as! Shift
        newShift.date = chooseDate.date
        newShift.startTime = startTime.date
        newShift.endTime = finishTime.date
        newShift.waiter = waiter
        var setArray = [Shift]()
        setArray.append(newShift)
        let shifts = Set(setArray)
        waiter.addShift(shifts)
        }
        
        delegate.saveContext()
        dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func cancelShift(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
