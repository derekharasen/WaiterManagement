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

@end

@implementation NewShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    aShift.startDate = self.startDateTextField.text;
    aShift.endDate = self.endDateTextField.text;
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
