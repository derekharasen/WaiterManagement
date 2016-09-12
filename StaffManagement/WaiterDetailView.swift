//
//  WaiterDetailView.swift
//  StaffManagement
//
//  Created by Carl Udren on 9/10/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

protocol WaiterDetailViewDelegate {
    func handleButton()
}

class WaiterDetailView: UIView {
    
    // MARK: Properties
    let waiter: Waiter
    let label = UILabel()
    let button = UIButton()
    var delegate: WaiterDetailViewDelegate?
    
    // MARK: Initialization
    
    init(waiter: Waiter, buttonTitle: String) {
        self.waiter = waiter
        super.init(frame: CGRect.zero)
        prepareBackground()
        prepareLabel()
        prepareButton(buttonTitle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Prep
    
    func prepareBackground() {
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    }
    
    func prepareLabel() {
        label.font = UIFont.systemFontOfSize(30)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = waiter.name
        addSubview(label)
    }
    
    func prepareButton(title: String) {
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        addSubview(button)
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        layoutLabel()
        layoutButton()
    }
    
    func layoutLabel() {
        label.frame = CGRect(x: 10, y: bounds.height/4, width: bounds.width - 20, height: bounds.height/3)
    }
    
    func layoutButton() {
        button.frame = CGRect(x: 10, y: bounds.height - 40, width: 200, height: 30)
    }
    
    // MARK: Delegation
    
    func handleButton() {
        if let d = delegate {
            d.handleButton()
        }
    }
    
}
