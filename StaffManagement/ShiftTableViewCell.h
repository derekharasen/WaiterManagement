//
//  ShiftTableViewCell.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-14.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;



@end
