//
//  AddShiftViewController.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter+CoreDataProperties.h"
#import "Shift+CoreDataProperties.h"

@interface AddShiftViewController : UIViewController

@property (nonatomic) Waiter *waiter;
@property (nonatomic) Shift *shift;

- (void)displayShiftView:(Waiter *)waiter;
- (void)displayShiftForEdit:(Shift *)shift;

@end
