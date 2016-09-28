//
//  AddShiftViewController.h
//  StaffManagement
//
//  Created by Carl Udren on 9/11/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter+CoreDataProperties.h"

@interface AddShiftViewController : UIViewController

- (instancetype) initWithWaiter: (Waiter *) waiter;

@end
