//
//  AddWaiterViewController.m
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "AddWaiterViewController.h"
#import "AppDelegate.h"
#import "RestaurantManager.h"


@interface AddWaiterViewController ()

@end

@implementation AddWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add New Waiter";
}


- (IBAction)done{
    
    // Verify that the waiter's name has been entered
    NSCharacterSet *blank = [NSCharacterSet whitespaceCharacterSet];
    if ([[self.textField.text stringByTrimmingCharactersInSet:blank]length] == 0){

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter Name"
                                                       message:@"Please enter the waiter's name"
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        RestaurantManager *restaurantManager = [RestaurantManager sharedManager];
        [restaurantManager addWaiterFromString:self.textField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
