//
//  AddShiftViewController.m
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "AddShiftViewController.h"
#import "RestaurantManager.h"
#import "Shift.h"

@interface AddShiftViewController ()

@end

@implementation AddShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Shift";
    
    self.timePicker = [[UIDatePicker alloc]init];
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    self.timePicker.minuteInterval = 15;
    
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.startField.inputView = self.timePicker;
    self.endField.inputView = self.timePicker;
    self.dateField.inputView = self.datePicker;
}


- (IBAction)addShift{
    
    // Check if any fields have been left blank
    NSCharacterSet *blank = [NSCharacterSet whitespaceCharacterSet];
    if ([[self.startField.text stringByTrimmingCharactersInSet:blank]length] == 0 || [[self.endField.text stringByTrimmingCharactersInSet:blank]length] == 0 || [[self.dateField.text stringByTrimmingCharactersInSet:blank]length] == 0 ){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Complete Fields"
                                                       message:@"One or more fields have been left blank."
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
        [alert show];
    }
    else{
        [[RestaurantManager sharedManager]addShiftWithDate:self.dateField.text start:self.startField.text end:self.endField.text forWaiter:self.waiter];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITextField

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self createInputAccessoryView];
    [textField setInputAccessoryView:self.inputAccView];
    self.activeField = textField;
}

-(void)createInputAccessoryView{

    self.inputAccView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen]applicationFrame].size.width,40)];
    [[self.inputAccView layer] setBorderWidth:1.0f];
    [[self.inputAccView layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UIButton *doneButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [doneButton setFrame: CGRectMake(0.0, 0.0, 80.0, 40.0)];
    [doneButton setTitle: @"Done" forState: UIControlStateNormal];
    [[doneButton layer] setBorderWidth:1.0f];
    [[doneButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputAccView addSubview:doneButton];
}


-(void)doneTyping{
    //Choose date format based on textfield
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    if (self.activeField != self.dateField) {
        [outputFormatter setDateFormat:@"h:mm a"];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        self.activeField.text = [outputFormatter stringFromDate:self.timePicker.date];
    }
    else{
        outputFormatter.dateStyle = NSDateFormatterMediumStyle;
        self.activeField.text = [outputFormatter stringFromDate:self.datePicker.date];
    }
    [self.activeField resignFirstResponder];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
