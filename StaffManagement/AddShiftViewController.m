//
//  AddShiftViewController.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "AddShiftViewController.h"

@interface AddShiftViewController ()

@end

@implementation AddShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"Set Up Shift";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addShift:(UIBarButtonItem *)sender {
    
}

- (IBAction)cancelAddShift:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
