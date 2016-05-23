//
//  AddShiftViewController.swift
//  StaffManagement
//
//  Created by Karlo Pagtakhan on 05/20/2016.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit

class AddShiftViewController: UIViewController {
  //MARK: Variables
  var waiter:Waiter!
  var startTime:NSDate?
  var endTime:NSDate?
  var defaultDate = NSDate()
  
  //MARK: Outlet
  @IBOutlet var shiftName: UITextField!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var saveButton: UIButton!
  
  //MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    prepareView()
    prepareDefaults()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  //MARK: Preparation
  func prepareView(){
    tableView.delegate = self
    tableView.dataSource = self
    shiftName.delegate = self
    
    //Configure buttons
    saveButton.layer.borderWidth = 1.0
    saveButton.layer.cornerRadius = 5
    saveButton.layer.borderColor = UIColor(red: 80/255, green: 174/255, blue: 85/255, alpha: 1.0).CGColor
    saveButton.backgroundColor = UIColor(red: 80/255, green: 174/255, blue: 85/255, alpha: 1.0)
    saveButton.tintColor = UIColor.whiteColor()
    cancelButton.layer.borderWidth = 1.0
    cancelButton.layer.cornerRadius = 5
    cancelButton.layer.borderColor = UIColor.redColor().CGColor
    cancelButton.backgroundColor = UIColor.redColor()
    cancelButton.tintColor = UIColor.whiteColor()
  }
  func prepareDefaults(){
    let formatter = NSDateFormatter()
    formatter.dateFormat = Constants.Date.timeFormat
    defaultDate = formatter.dateFromString(Constants.Date.time)!
    
    startTime = defaultDate
    endTime = defaultDate
  }
  //MARK: Actions
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  @IBAction func save(sender: AnyObject) {
    //Shift name shouldn't be initial
    if shiftName.text != ""{
      //Save shift then dismiss vc
      if (RestaurantManager.sharedManager().saveShiftToWaiter(waiter,
        withShift: shiftName.text,
        withStart: startTime,
        withEnd: endTime) != nil){
        dismissViewControllerAnimated(true, completion: nil)
      } else{
        displayAlert(Constants.Alert.Title.error, message: Constants.Alert.Message.shiftSaveError)
      }
    } else{
      displayAlert(Constants.Alert.Title.error, message: Constants.Alert.Message.shiftNoName)
    }
  }
  //MARK: Helper
  func configureTableViewCell(tableView: UITableView, indexPath: NSIndexPath)->UITableViewCell{
    let configuredCell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeTableViewCell
    
    //Set value observer
    if configuredCell.datePicker.allTargets().count == 0{
      configuredCell.datePicker.addTarget(self, action: #selector(AddShiftViewController.dataPickerChanged), forControlEvents: UIControlEvents.ValueChanged)
      configuredCell.datePicker.date = defaultDate
    }
    
    //Configure properties
    switch indexPath.row {
    case 0:
      configuredCell.rowTitle.text = Constants.Form.Shift.start
      configuredCell.datePicker.tag = 0
    case 1:
      configuredCell.rowTitle.text = Constants.Form.Shift.end
      configuredCell.datePicker.tag = 1
    default:
      return UITableViewCell()
    }
    
    return configuredCell
  }
  func dataPickerChanged(datePicker:UIDatePicker){
    //Hide Keyboard
    shiftName.resignFirstResponder()
    
    if datePicker.tag == 0{
      startTime = datePicker.date
      print("for Start: \(datePicker.date)")
    }
    if datePicker.tag == 1{
      endTime = datePicker.date
      print("for End: \(datePicker.date)")
    }
  }
  func displayAlert(title: String, message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: Constants.Alert.Button.ok, style: .Default, handler: nil))
    presentViewController(alertController, animated: true, completion: nil)
  }
}
//MARK: - UITextFieldDelegate
extension AddShiftViewController:UITextFieldDelegate{
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
//MARK: - UITableViewDataSource
extension AddShiftViewController:UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = configureTableViewCell(tableView, indexPath: indexPath)
    return cell
  }
}
//MARK: - UITableViewDelegate
extension AddShiftViewController:UITableViewDelegate{
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 130
  }
}