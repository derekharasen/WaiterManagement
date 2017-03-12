//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-11.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

protocol ReloadTableView {
    func reloadTableView()
}


class ShiftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReloadTableView {
    var waiter: Waiter!
    var shiftArray = [Shift]()
    
    @IBOutlet weak var saveWaiterNameButton: UIButton!
    @IBOutlet weak var shiftTableView: UITableView!
    @IBOutlet weak var waiterNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        waiterNameTextField.text = waiter.name
        waiterNameTextField.alpha = 0.5
        setUpArray()
    }

    //This button/method is used to enable editing the waiter's name
    @IBAction func tapWaiterNameButton(_ sender: UIButton) {
        if sender.title(for: .normal) == "Edit" {
            waiterNameTextField.isUserInteractionEnabled = true
            sender.setTitle("Save", for: .normal)
            waiterNameTextField.alpha = 1
            return
        }
        sender.setTitle("Edit", for: .normal)
        waiterNameTextField.isUserInteractionEnabled = false
        waiterNameTextField.alpha = 0.5
        waiter.name = waiterNameTextField.text
        DataManager.sharedInstance.saveContext()
    }
    

    //MARK: TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shiftArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shifts"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftTableViewCell", for: indexPath) as! ShiftTableViewCell
        let dateFormatter = DateFormatter()
        cell.startTimeLabel.text = "No start time found"
        cell.endTimeLabel.text = "No end time found"
        guard let startTime = shiftArray[indexPath.row].startTime, let endTime = shiftArray[indexPath.row].endTime else {
            return cell
        }
        dateFormatter.dateFormat = "MMM dd      HH:mm"
        cell.startTimeLabel.text = "Start: " + dateFormatter.string(from: startTime)
        cell.endTimeLabel.text = "End: " + dateFormatter.string(from: endTime)
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dataManager = DataManager.sharedInstance
            dataManager.deleteObject(shiftArray[indexPath.row])
            dataManager.saveContext()
            shiftArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddShiftTableViewController" {
            let astvc = segue.destination as! AddShiftTableViewController
            astvc.delegate = self
            astvc.waiter = waiter
        }
        
        if segue.identifier == "EditShift" {
            let astvc = segue.destination as! AddShiftTableViewController
            astvc.delegate = self
            astvc.waiter = waiter
            astvc.shift = shiftArray[shiftTableView.indexPathForSelectedRow!.row]
        }
    }
    
    //MARK: Helper methods
    //This method gest the shift array and sorts it by start date
    func setUpArray() {
        guard let shifts = waiter.shifts else {
            return
        }
        shiftArray = Array(shifts)
        shiftArray.sort(by: { $0.startTime!.compare($1.startTime!) == .orderedAscending})
    }
    
    //This method is used to reset the data when a new shift is added
    func reloadTableView() {
        setUpArray()
        shiftTableView.reloadData()
    }
}
