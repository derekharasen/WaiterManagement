//
//  AddShiftViewController.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter+CoreDataClass.h"

@interface AddShiftViewController : UIViewController

@property (nonatomic) Waiter *waiter;

- (void)displayShiftView:(Waiter *)waiter;

@end
