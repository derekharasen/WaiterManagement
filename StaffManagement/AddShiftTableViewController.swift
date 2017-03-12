//
//  AddShiftTableViewController.swift
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-11.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class AddShiftTableViewController: UITableViewController {
    var delegate: ReloadTableView?
    var waiter: Waiter!
    var shift: Shift?
    let dateFormatter = DateFormatter()
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet var addShiftTableView: UITableView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var row1Height = 0
    var row3Height = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MMMM dd yyyy      HH:mm"
        if let shift = shift {
            startDatePicker.date = shift.startTime!
            endDatePicker.date = shift.endTime!
            startTimeLabel.text = dateFormatter.string(from: shift.startTime!)
            endTimeLabel.text = dateFormatter.string(from: shift.endTime!)
            return
        }
        startTimeLabel.text = dateFormatter.string(from: Date())
        endTimeLabel.text = dateFormatter.string(from: Date()+3600)
        endDatePicker.date = Date()+3600
    }
    
    //MARK: TableView Data Source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return CGFloat(row1Height)
        }
        if indexPath.row == 3 {
            return CGFloat(row3Height)
        }
        return 44
    }
    
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            toggleRow(1)
        }
        
        if indexPath.row == 2 {
            toggleRow(3)
        }
    }
    
    //MARK: Toggle the pickers from expanded to closed
    func toggleRow(_ row: Int) {
        self.addShiftTableView.beginUpdates()
        if row == 1 {
            if row1Height == 0 {
                startDatePicker.isHidden = false
                row1Height = 150
            } else {
                startDatePicker.isHidden = true
                row1Height = 0
            }
        }
        
        if row == 3 {
            if row3Height == 0 {
                endDatePicker.isHidden = false
                row3Height = 150
            } else {
                endDatePicker.isHidden = true
                row3Height = 0
            }
        }
        self.addShiftTableView.endUpdates()
    }
    
    //MARK: Shift setting methods
    @IBAction func startTimePicked(_ sender: UIDatePicker) {
        startTimeLabel.text = formatDate(sender.date)
        toggleSaveButton()
    }
    
    @IBAction func endTimePicked(_ sender: UIDatePicker) {
        endTimeLabel.text = formatDate(sender.date)
        toggleSaveButton()
    }
    
    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func toggleSaveButton() {
        if endDatePicker.date < startDatePicker.date {
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
    
    @IBAction func saveShift(_ sender: UIBarButtonItem) {
        if shift == nil {
            shift = DataManager.sharedInstance.generateShift()
            waiter.addShiftsObject(shift!)
        }
        shift!.startTime = startDatePicker.date
        shift!.endTime = endDatePicker.date
        DataManager.sharedInstance.saveContext()
        delegate?.reloadTableView()
        _ = navigationController?.popViewController(animated: true)
    }
}
