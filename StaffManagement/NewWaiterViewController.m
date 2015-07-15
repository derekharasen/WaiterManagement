//
//  NewWaiterViewController.m
//  StaffManagement
//
//  Created by Kunwardeep Gill on 2015-07-13.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "NewWaiterViewController.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "RestaurantManager.h"

@interface NewWaiterViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *waiterNameTextField;


@end

@implementation NewWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction

- (IBAction)closeButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveButtonPressed:(id)sender {
    
    NSError *error;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
    
    Waiter *newWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    newWaiter.name = self.waiterNameTextField.text;
    [[[RestaurantManager sharedManager]currentRestaurant] addStaffObject:newWaiter];
    
    [appDelegate.managedObjectContext save:&error];
    [self dismissViewControllerAnimated:YES completion:nil];

}



@end
