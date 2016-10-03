//
//  ShiftsTableViewController.swift
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-10-01.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import UIKit


class ShiftsTableViewController: UITableViewController,  UIPickerViewDelegate {

    var shifts = [NSManagedObject]()
    var dateView = UIView()
    var datePickerStartDate = UIDatePicker()
    var datePickerEndDate = UIDatePicker()
    var shiftManager = ShiftManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavBar()
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //get shift list from core data
        self.shifts = self.shiftManager.updateShiftList()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
        let shift = self.shifts[indexPath.row] as NSManagedObject
        //set start time for cell
        let startTime = shift.value(forKey: "startTime") as! NSDate
        let formattedStartTime = self.formatDate(date: startTime as Date)
        myCell.startLabel.text = "Start: \(formattedStartTime)"
        //set end time for cell
        let endTime = shift.value(forKey: "endTime") as! NSDate
        let formattedEndTime = self.formatDate(date: endTime as Date)
        myCell.endLabel.text = "End: \(formattedEndTime)"
        
        return myCell
    }
    
    func saveStartDate(sender:UIButton) {
        //saves shift in core data
        self.shiftManager.saveShift(startTime: self.datePickerStartDate.date as NSDate, endTime: self.datePickerEndDate.date as NSDate)
        //close view to add shift
        self.dateView.removeFromSuperview()
        navigationItem.rightBarButtonItem?.title = "Add"
        //update tableview with shifts from core data
        self.shifts = self.shiftManager.updateShiftList()
        self.tableView.reloadData()
    }
    
    func setUpNavBar() {
        navigationItem.title = "Shifts"
        //when select add button the date view will launch
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(dateViewSetUp))
    }
    
    func dateViewSetUp() {
        
        navigationItem.rightBarButtonItem?.title = ""
        
        self.dateView = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height)))
        self.dateView.backgroundColor = UIColor.white
        self.view.addSubview(self.dateView)
    
        self.setUpDatePickers()
        self.setUpSaveButton()
        self.setUpLabels()
    }
    
    func setUpSaveButton() {
        let saveButton = UIButton(frame: CGRect(origin: CGPoint(x:(self.view.frame.size.width/2 - 100/2), y:0), size: CGSize(width: 100, height: 50)))
        saveButton.setTitle("Save", for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        self.dateView.addSubview(saveButton)
        //Add action to button to save information to core data
        saveButton.addTarget(self, action: #selector(saveStartDate(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func setUpLabels() {
        //Enter Start Time Label
        let startTimeLabel = UILabel(frame: CGRect(origin: CGPoint(x:20, y:50), size: CGSize(width: 300, height: 50)))
        startTimeLabel.text = "Choose Shift Start Date & Time:"
        startTimeLabel.textColor = UIColor.gray
        self.dateView.addSubview(startTimeLabel)
        
        //Enter End Time Label
        let endTimeLabel = UILabel(frame: CGRect(origin: CGPoint(x:20, y:315), size: CGSize(width: 300, height: 50)))
        endTimeLabel.text = "Choose Shift End Date & Time:"
        endTimeLabel.textColor = UIColor.gray
        self.dateView.addSubview(endTimeLabel)
    }
    
    func setUpDatePickers() {
        //Start Date DatePicker
        self.datePickerStartDate = UIDatePicker(frame: CGRect(origin: CGPoint(x:20, y:100), size: CGSize(width: 0, height:0)))
        self.datePickerStartDate.datePickerMode = UIDatePickerMode.dateAndTime
        self.dateView.addSubview(self.datePickerStartDate)
        
        //End Date DatePicker
        self.view.addSubview(self.dateView)
        self.datePickerEndDate = UIDatePicker(frame: CGRect(origin: CGPoint(x:20, y:350), size: CGSize(width: 0, height:0)))
        self.datePickerEndDate.datePickerMode = UIDatePickerMode.dateAndTime
        self.dateView.addSubview(self.datePickerEndDate)
    }
    
    func formatDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd/MM/yy"
        let convertedDate = dateFormatter.string(from: date as Date)
        return convertedDate
    }
}
    
class MyCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
    
    let startLabel: UILabel = {
        let startLabel = UILabel(frame: CGRect(origin: CGPoint(x:10, y:0), size: CGSize(width: 200, height: 50)))
        startLabel.text = "Start Time:"
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        return startLabel
    }()
    
    let endLabel: UILabel = {
        let endLabel = UILabel(frame: CGRect(origin: CGPoint(x:200, y:0), size: CGSize(width: 200, height: 50)))
        endLabel.text = "End Time:"
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        return endLabel
    }()

    func setupViews() {
        addSubview(startLabel)
        addSubview(endLabel)
    }
}
