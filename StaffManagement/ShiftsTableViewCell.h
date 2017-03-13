//
//  ShiftsTableViewCell.h
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiftsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@end
