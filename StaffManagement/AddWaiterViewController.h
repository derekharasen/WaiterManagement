//
//  AddWaiterViewController.h
//  StaffManagement
//
//  Created by Daniel Hooper on 2016-04-14.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWaiterViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
