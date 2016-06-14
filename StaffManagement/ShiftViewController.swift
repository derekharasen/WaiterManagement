//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Stephen Gilroy on 2016-06-10.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var waiter: Waiter!
    var shifts = [Shift]()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadShifts()
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        loadShifts()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    
    // Table data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shifts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ShiftCell", forIndexPath: indexPath)
        
        // Format date/time
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let formattedDate = dateFormatter.stringFromDate(self.shifts[indexPath.row].start!)
        let formattedStartTime = timeFormatter.stringFromDate(self.shifts[indexPath.row].start!)
        let formattedEndTime = timeFormatter.stringFromDate(self.shifts[indexPath.row].end!)
        
        // Display on label
        cell.textLabel?.text = formattedDate
        cell.detailTextLabel?.text = "\(formattedStartTime) to \(formattedEndTime)"
        
        return cell
    }
    
    // Allow deletion of rows
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == .Delete) {
            // Delete object from Core Data
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            managedContext.deleteObject(shifts[indexPath.row])
            
            // Save context
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            
            // Update table view
            loadShifts()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func backButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        (segue.destinationViewController as? AddShiftViewController)?.waiter = self.waiter
    }
    
    // MARK: - Core Data helper functions
    
    func loadShifts(){
        
        // Fetch shift information from Core Data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create fetch request and predicate
        let fetchRequest = NSFetchRequest(entityName: "Shift")
        fetchRequest.predicate = NSPredicate(format: "%K LIKE %@", "waiter.name", waiter.name)
        
        // Attempt the fetch, save to local shifts array and order
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [Shift]
            self.shifts = results
            self.shifts.sortInPlace({$0.start!.compare($1.start!) == .OrderedAscending})
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
