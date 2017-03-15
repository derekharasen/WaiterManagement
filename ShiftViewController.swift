//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-14.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftViewController: UIViewController {
    
    var shift: Shift?
    var waiter: Waiter?
    var waiters = [Waiter]()
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
    
    public func displayShiftView(waiter:Waiter) {
        self.waiter = waiter
    }
    
    public func dispalyShiftForEdit(shift:Shift) {
        self.shift = shift
        self.waiter = shift.waiter!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveShift(_ sender: UIBarButtonItem) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        if let existingShift = shift {
            existingShift.date = chooseDate.date
            existingShift.startTime = startTime.date
            existingShift.endTime = finishTime.date
        } else {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Waiter")
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                waiters = try managedContext.fetch(fetchRequest) as! [Waiter]
            } catch {
                print("Fetching Failed")
            }
            
            let newShift:Shift = NSEntityDescription.insertNewObject(forEntityName: "Shift", into:delegate.managedObjectContext) as! Shift
            newShift.date = chooseDate.date
            newShift.startTime = startTime.date
            newShift.endTime = finishTime.date
            newShift.waiter = waiter
            var setArray = [Shift]()
            setArray.append(newShift)
            let shifts = Set(setArray)
            waiter?.addShift(shifts)
        }
        
        delegate.saveContext()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelShift(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
