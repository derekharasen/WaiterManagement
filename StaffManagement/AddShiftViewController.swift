//
//  AddShiftViewController.swift
//  StaffManagement
//
//  Created by Daniel Hooper on 2016-04-14.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit
import CoreData

@objc class AddShiftViewController: UIViewController {
    
    var detailItem: NSManagedObject? = nil;
    var managedObjectContext: NSManagedObjectContext? = nil;
    var dateTextField: UITextField!
    var startTextField: UITextField!
    var endTextField: UITextField!
    var date: NSDate!
    var start: NSDate!
    var end: NSDate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        // Create
        let dateLabel: UILabel     = UILabel()
        dateLabel.frame            = CGRectMake(0.0, 100.0, self.view.frame.width, 25.0)
        dateLabel.backgroundColor  = UIColor.whiteColor()
        dateLabel.textColor        = UIColor.blackColor()
        dateLabel.textAlignment    = NSTextAlignment.Center
        dateLabel.text             = "Select a date"
        
        let startLabel: UILabel    = UILabel()
        startLabel.frame           = CGRectMake(0.0, 175.0, self.view.frame.width, 25.0)
        startLabel.backgroundColor = UIColor.whiteColor()
        startLabel.textColor       = UIColor.blackColor()
        startLabel.textAlignment   = NSTextAlignment.Center
        startLabel.text            = "Select a start time"
        
        let endLabel: UILabel      = UILabel()
        endLabel.frame             = CGRectMake(0.0, 250.0, self.view.frame.width, 25.0)
        endLabel.backgroundColor   = UIColor.whiteColor()
        endLabel.textColor         = UIColor.blackColor()
        endLabel.textAlignment     = NSTextAlignment.Center
        endLabel.text              = "Select an end time"
        
        let saveButton     = UIButton(type: UIButtonType.System);
        saveButton.frame   = CGRectMake(self.view.frame.width - 100.0, 30.0, 100.0, 30.0);
        saveButton.setTitle("Save", forState: UIControlState.Normal);
        saveButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        saveButton.addTarget(self, action: #selector(AddShiftViewController.saveButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
        let cancelButton   = UIButton(type: UIButtonType.System);
        cancelButton.frame = CGRectMake(0.0, 30.0, 100.0, 30.0);
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal);
        cancelButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        cancelButton.addTarget(self, action: #selector(AddShiftViewController.cancelButtonPressed(_:)), forControlEvents: UIControlEvents.EditingDidBegin);

        dateTextField  = UITextField(frame:CGRectMake(0.0 + ((self.view.frame.width * 0.25) / 2), 130.0, self.view.frame.width * 0.75, 24.0));
        dateTextField.borderStyle = UITextBorderStyle.RoundedRect
        dateTextField.addTarget(self, action: #selector(AddShiftViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.EditingDidBegin);
        dateTextField.tag = 0

        startTextField = UITextField(frame:CGRectMake(0.0 + ((self.view.frame.width * 0.25) / 2), 205.0, self.view.frame.width * 0.75, 24.0));
        startTextField.borderStyle = UITextBorderStyle.RoundedRect;
        startTextField.addTarget(self, action: #selector(AddShiftViewController.handleTimePicker(_:)), forControlEvents: UIControlEvents.EditingDidBegin);
        startTextField.tag = 1

        endTextField   = UITextField(frame:CGRectMake(0.0 + ((self.view.frame.width * 0.25) / 2), 280.0, self.view.frame.width * 0.75, 24.0));
        endTextField.borderStyle = UITextBorderStyle.RoundedRect;
        endTextField.addTarget(self, action: #selector(AddShiftViewController.handleTimePicker(_:)), forControlEvents: UIControlEvents.EditingDidBegin)
        endTextField.tag = 2
        
        self.view.addSubview(dateTextField);
        self.view.addSubview(startTextField);
        self.view.addSubview(endTextField);
        self.view.addSubview(saveButton);
        self.view.addSubview(cancelButton);
        self.view.addSubview(dateLabel)
        self.view.addSubview(startLabel)
        self.view.addSubview(endLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveButtonPressed(sender:UIButton!) {
        let context = self.managedObjectContext!
        let entity  = NSEntityDescription.entityForName("Shift", inManagedObjectContext:context)
        let shift: Shift = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:context) as! Shift
        
        shift.setValue(date, forKey: "date")
        shift.setValue(start, forKey: "start")
        shift.setValue(end, forKey: "end")
        
        let set = NSSet()
        set.setByAddingObject(shift)
        
        let waiter: Waiter = detailItem as! Waiter
        waiter.addShifts(set as! Set<Shift>)
        
        shift.waiter = waiter
        
        print(shift)

        do {
            try context.save()
        } catch {
            print("Could not save")
        }
        
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func cancelButtonPressed(sender:UIButton!) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func handleDatePicker(sender:UITextField!) {
        print("Date Picker Handled")
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode    = UIDatePickerMode.Date
        sender.inputView                 = datePickerView
        datePickerView.addTarget(self, action: #selector(AddShiftViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter       = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateTextField.text      = dateFormatter.stringFromDate(sender.date)
        date = sender.date
        dateTextField.resignFirstResponder()
    }
    
    func handleTimePicker(sender:UITextField!) {
        print("Time Picker Handled")
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.tag               = sender.tag
        datePickerView.datePickerMode    = UIDatePickerMode.Time
        sender.inputView                 = datePickerView
        datePickerView.addTarget(self, action: #selector(AddShiftViewController.timePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func timePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter       = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        if sender.tag == 1 {
            startTextField.text = dateFormatter.stringFromDate(sender.date)
            start = sender.date
            startTextField.resignFirstResponder()
        } else if sender.tag == 2 {
            endTextField.text   = dateFormatter.stringFromDate(sender.date)
            end = sender.date
            endTextField.resignFirstResponder()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
