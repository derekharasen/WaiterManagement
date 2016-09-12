//
//  ShiftDetailViewController.swift
//  StaffManagement
//
//  Created by Carl Udren on 9/10/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ShiftDetailViewController: UIViewController {
    
    // MARK: Properties
    private let kCellIdentifier: String = "ShiftReuseIdentifier"
    private let tableView: UITableView = UITableView(frame: CGRect.zero, style: .Plain)
    let waiter: Waiter
    private let headerView: WaiterDetailView
    private let formatter = NSDateFormatter()
    var shifts: [Shift] = [Shift]()
    
    // MARK: Initialization
    init(waiter: Waiter) {
        self.waiter = waiter
        self.headerView = WaiterDetailView(waiter: waiter, buttonTitle: "Add Shift")
        super.init(nibName: nil, bundle: nil)
        self.shifts = updateShifts(waiter)
        self.headerView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDateFormatter()
        prepareTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.shifts = updateShifts(waiter)
        tableView.reloadData()
    }
    
    // MARK: View Preparation
    
    private func prepareDateFormatter() {
        formatter.dateFormat = "M/dd/yy hh:ss a"
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)

        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.tableHeaderView = headerView
    }
    
    // MARK: Helper
    
    private func updateShifts(waiter: Waiter) -> [Shift] {
        if let s = waiter.shift {
            return s.sort({ (a, b) -> Bool in
                a.startTime?.compare(b.startTime!) == NSComparisonResult.OrderedAscending
            })
        } else {
             return [Shift]()
        }
    }
    
}

extension ShiftDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)!
        let shift = shifts[indexPath.row]
        cell.textLabel?.text = "start: " + formatter.stringFromDate(shift.startTime!) + "\nend:  " + formatter.stringFromDate(shift.endTime!)
        cell.textLabel?.numberOfLines = 2;
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}

extension ShiftDetailViewController: WaiterDetailViewDelegate {
    func handleButton() {
        let addShift = AddShiftViewController(waiter: waiter)
        let nav = UINavigationController(rootViewController: addShift)
        
        presentViewController(nav, animated: true, completion: nil)
    }
}