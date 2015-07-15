//
//  NewShiftViewController.m
//  StaffManagement
//
//  Created by Kunwardeep Gill on 2015-07-15.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "NewShiftViewController.h"
#import "AppDelegate.h"
#import "Shift.h"
#import "Waiter.h"

@interface NewShiftViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *startDateTextField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTextField;
@property (strong, nonatomic) UIDatePicker *datePicker;


@end

@implementation NewShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startDateTextField.delegate = self;
    self.endDateTextField.delegate = self;
    
    //  Initial datePicker when viewloaded
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    
    self.startDateTextField.inputView = self.datePicker;
    self.endDateTextField.inputView = self.datePicker;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    
    //  Checks to see if value changed.
    [self.datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  hide the datepicker when anything else is touched
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.startDateTextField resignFirstResponder];
    [self.endDateTextField resignFirstResponder];
}

//  update the textfield with the date selected

- (void)updateDateField:(id)sender
{
    
    UIDatePicker *picker1 = (UIDatePicker *)self.startDateTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    
    if (self.startDateTextField.isFirstResponder) {
        
        self.startDateTextField.text = [dateFormat stringFromDate:picker1.date];
        
    } else {
        self.endDateTextField.text = [dateFormat stringFromDate:picker1.date];
        
    }
}

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveButtonPressed:(id)sender {
    
    NSError *error;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSEntityDescription *shiftEntity = [NSEntityDescription entityForName:@"Shift" inManagedObjectContext:appDelegate.managedObjectContext];
    
    Shift *aShift = [[Shift alloc]initWithEntity:shiftEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    aShift.startDate = [NSString stringWithFormat:@"Start: %@", self.startDateTextField.text];
    aShift.endDate = [NSString stringWithFormat:@"End: %@", self.endDateTextField.text];
    Waiter *aWaiter;
    aWaiter = self.waiter;
    
    [aWaiter addShiftsObject:aShift];
    
    [appDelegate.managedObjectContext save:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
