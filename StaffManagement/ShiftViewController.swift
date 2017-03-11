//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-11.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var waiter: Waiter!
    
    @IBOutlet weak var shiftTableView: UITableView!
    @IBOutlet weak var waiterNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        waiterNameTextField.text = waiter.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shifts = waiter.shifts else {
            return 0
        }
        return shifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftTableViewCell", for: indexPath)
        return cell
    }
}
