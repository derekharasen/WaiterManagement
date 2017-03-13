//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "ShiftsViewController.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController ()
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *waiters;
@property RestaurantManager *manager;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameTextField setDelegate:self];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]] mutableCopy];
    self.manager = [RestaurantManager sharedManager];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    Waiter *waiter = self.waiters[indexPath.row];
    cell.textLabel.text = waiter.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *name = cell.textLabel.text;
    if (name == nil){
        return;
    }
    self.manager.selected = [self.manager getWaiter:name];
    [self performSegueWithIdentifier:@"Shifts" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *name = cell.textLabel.text;
    if (self.waiters.count > 0){
        Waiter *removedWaiter = [self.manager getWaiter:name];
        if(removedWaiter != nil){
            [self.waiters removeObject:removedWaiter];
            [self.manager removeWaiter:name];
            [self.tableView reloadData];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.nameTextField.text == nil){
        return YES;
    }
    Waiter *newWaiter = [self.manager newWaiter:self.nameTextField.text];
    if (newWaiter != nil){
        [self.waiters addObject:newWaiter];
        [self.tableView reloadData];
    }
    self.nameTextField.text = nil;
    [textField resignFirstResponder];
    return YES;
}

@end
