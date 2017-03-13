//
//  AddWaiterViewController.h
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter+CoreDataProperties.h"

@interface AddWaiterViewController : UIViewController

@property (nonatomic) Waiter *waiter;

- (void)displayDetailView:(Waiter *)waiter;

@end
