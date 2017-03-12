//
//  ShiftTableViewCell.swift
//  StaffManagement
//
//  Created by Minhung Ling on 2017-03-11.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftTableViewCell: UITableViewCell {

    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
