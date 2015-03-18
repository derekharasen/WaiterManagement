//
//  ShiftViewController.h
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter.h"

@interface ShiftsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Waiter *waiter;

- (void)add;

@end
