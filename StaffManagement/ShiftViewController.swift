//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Karlo Pagtakhan on 05/19/2016.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftViewController: UIViewController {
  //MARK: Variables
  var waiter: Waiter?
  var shifts = [Shift]()
  var timeFormatter:NSDateFormatter!
  
  //MARK: Outlet
  @IBOutlet var tableView: UITableView!
  
  //MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    prepareView()
    prepareObservers()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: Preparation
  func prepareView(){
    tableView.delegate = self
    tableView.dataSource = self
    
    //Navigation Controller and bar set up
    navigationItem.title = waiter?.name
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ShiftViewController.add))
    
    //Get data and reload table
    updateData()
    
    //Setup date formatter
    timeFormatter = NSDateFormatter()
    timeFormatter.dateFormat = Constants.Date.timeFormat
  }
  func prepareObservers(){
    //Prevent duplicate observer
    NSNotificationCenter.defaultCenter().removeObserver(self, name: NSManagedObjectContextObjectsDidChangeNotification, object: waiter?.managedObjectContext)
    
    //Capture inserted shifts
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShiftViewController.checkIfDataShouldUpdate), name:NSManagedObjectContextObjectsDidChangeNotification, object: waiter?.managedObjectContext)
  }
  //MARK: Actions
  func add(){
    performSegueWithIdentifier("showAddShift", sender: self)
  }
  //MARK: Helper
  func checkIfDataShouldUpdate(notification: NSNotification){
    guard let userInfo = notification.userInfo else { return }
    
    //There should be exactly 1 insert Shift object
    if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> where inserts.count == 1 && inserts.first!.entity.name! == "Shift"{
      updateData(true)
    }
  }
  func updateData(reload:Bool = false){
    shifts = RestaurantManager.sharedManager().getShiftsForWaiter(waiter) as [Shift]
    shifts.sortInPlace { $0.name.compare($1.name) == NSComparisonResult.OrderedAscending }
    if reload{
      tableView.reloadData()
    }
  }
  func configureTableViewCell(tableView: UITableView, indexPath: NSIndexPath)->UITableViewCell{
    let configuredCell = tableView.dequeueReusableCellWithIdentifier("ShiftCell", forIndexPath: indexPath)
    
    //Get data
    let shift = shifts[indexPath.row]
    
    //Format time
    let formattedStart = timeFormatter.stringFromDate(shift.startTime)
    let formattedEnd = timeFormatter.stringFromDate(shift.endTime)
    
    //Set values
    configuredCell.textLabel!.text = shift.name
    configuredCell.detailTextLabel!.text = "\(formattedStart) - \(formattedEnd)"
    
    return configuredCell
  }
  func deleteShiftAtIndexPath(indexPath:NSIndexPath){
    //Delete shift then update table view. Else, show alert
    if RestaurantManager.sharedManager().deleteShift(shifts[indexPath.row]){
      shifts.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      tableView.reloadData()
    } else{
      displayAlert(Constants.Alert.Title.error, message: Constants.Alert.Message.shiftDeleteError)
    }
  }
  func displayAlert(title: String, message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: Constants.Alert.Button.ok, style: .Default, handler: nil))
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  //MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showAddShift"{
      prepareAddShiftViewController(segue.destinationViewController as!AddShiftViewController)
    }
  }
  func prepareAddShiftViewController(viewController: AddShiftViewController){
    viewController.waiter = waiter
  }
}
//MARK: - UITableViewDataSource
extension ShiftViewController:UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shifts.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = configureTableViewCell(tableView, indexPath: indexPath)
    return cell
  }
}
//MARK: - UITableViewDelegate
extension ShiftViewController:UITableViewDelegate{
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    switch editingStyle{
    case .Delete:
      deleteShiftAtIndexPath(indexPath)
    default: break
    }
  }
}