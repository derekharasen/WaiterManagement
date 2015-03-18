//
//  AddShiftViewController.h
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waiter.h"

@interface AddShiftViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Waiter *waiter;
@property (nonatomic, strong) IBOutlet UITextField *dateField;
@property (nonatomic, strong) IBOutlet UITextField *startField;
@property (nonatomic, strong) IBOutlet UITextField *endField;
@property (nonatomic, strong) UITextField *activeField;
@property (nonatomic, strong) UIDatePicker *timePicker;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *inputAccView;

-(IBAction)addShift;
-(void)doneTyping;
-(void)createInputAccessoryView;
@end
