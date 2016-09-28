//
//  AddWaiterViewController.m
//  StaffManagement
//
//  Created by Carl Udren on 9/10/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import "AddWaiterViewController.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Restaurant.h"
#import "RestaurantManager.h"

@interface AddWaiterViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation AddWaiterViewController

#pragma mark - VC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareBackground];
    [self prepareNavigationItem];
    [self prepareLabel];
    [self prepareTextField];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Preparation code

- (void) prepareBackground {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) prepareNavigationItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (void) prepareLabel {
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:13];
    self.label.textColor = [UIColor darkGrayColor];
    self.label.text = @"Waiter Name";
    [self.view addSubview:self.label];
}

- (void) prepareTextField {
    self.textField = [[UITextField alloc] init];
    [self.textField addTarget:self action:@selector(checkNameEntered) forControlEvents:UIControlEventEditingChanged];
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.textColor = [UIColor darkGrayColor];
    
    [self.view addSubview:self.textField];
}

#pragma mark - Layout

- (void) viewDidLayoutSubviews {
    [self layoutLabel];
    [self layoutTextField];
}

- (void) layoutLabel {
    CGFloat navBarMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.label.frame = CGRectMake(30, navBarMaxY + 30, self.view.bounds.size.width - 60, 30);
}

- (void) layoutTextField {
    self.textField.frame = CGRectMake(30, CGRectGetMaxY(self.label.frame), self.view.bounds.size.width - 60, 30);
}

#pragma mark - BarButton Handlers

- (void) save {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
    Waiter *newWaiter = [[Waiter alloc] initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    newWaiter.name = self.textField.text;
    [[RestaurantManager.sharedManager currentRestaurant] addStaffObject:newWaiter];
    
    [appDelegate saveContext];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate

- (void) checkNameEntered {
    if (self.textField.text.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

@end
