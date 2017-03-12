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
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet var addShiftTableView: UITableView!
    var row1Height = 0
    var row3Height = 0
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
    }
    
    @IBOutlet weak var startCell: UITableViewCell!
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return CGFloat(row1Height)
        }
        if indexPath.row == 3 {
            return CGFloat(row3Height)
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            toggleRow(1)
        }
        
        if indexPath.row == 2 {
            toggleRow(3)
        }
    }
    
    func toggleRow(_ row: Int) {
        if row == 1 {
            if row1Height == 0 {
                row1Height = 150
            } else {
                row1Height = 0
            }
        }
        
        if row == 3 {
            if row3Height == 0 {
                row3Height = 150
            } else {
                row3Height = 0
            }
        }
        self.addShiftTableView.beginUpdates()
        self.addShiftTableView.endUpdates()
    }
    
    @IBAction func startTimePicked(_ sender: UIDatePicker) {
        startTimeLabel.text = formatDate(sender.date)
        toggleSaveButton()
    }
    
    @IBAction func endTimePicked(_ sender: UIDatePicker) {
        endTimeLabel.text = formatDate(sender.date)
        toggleSaveButton()
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy      HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func toggleSaveButton() {
        if endDatePicker.date < startDatePicker.date {
            saveButton.isEnabled = false
            return
        }
        if startTimeLabel.text != "" && endTimeLabel.text != "" {
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func saveShift(_ sender: UIBarButtonItem) {
        let shift = DataManager.sharedInstance.generateShift()
        shift.startTime = startDatePicker.date
        shift.endTime = endDatePicker.date
        waiter.addShiftsObject(shift)
        DataManager.sharedInstance.saveContext()
        delegate?.reloadTableView()
        _ = navigationController?.popViewController(animated: true)
    }
    
}
