//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant+CoreDataClass.h"
#import "RestaurantManager.h"
#import "Waiter+CoreDataClass.h"
#import "StaffManagement-Swift.h"


static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *addWaiterButton;
@property IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addWaiterTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWaiterBarButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopAnchor;
@property (nonatomic, retain) NSMutableArray<Waiter*> *waiters;
@property (nonatomic) DataManager *dataManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *waiterArray = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    self.waiters = [NSMutableArray arrayWithArray:waiterArray];
    self.addWaiterButton.hidden = YES;
    self.addWaiterTextField.hidden = YES;
    self.dataManager = [DataManager sharedInstance];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void) reloadTableView {
    [self.tableView reloadData];
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
    NSMutableString *name = [NSMutableString stringWithString:waiter.name];
    if ([name isEqualToString:@""]) {
        name = [NSMutableString stringWithString:@"No name entered"];
    }
    cell.textLabel.text = name;
    return cell;
}
- (IBAction)addWaiterModeToggle:(UIBarButtonItem *)sender {
    self.addWaiterButton.hidden = !self.addWaiterButton.hidden;
    self.addWaiterTextField.hidden = !self.addWaiterTextField.hidden;
    if (self.addWaiterButton.hidden) {
        [UIView animateWithDuration:1
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:10
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             self.tableViewTopAnchor.constant = 0;
                             [self.view layoutIfNeeded];
                         }    completion:^(BOOL finished) {
                         }];
        return;
    }
    [UIView animateWithDuration:1
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         self.tableViewTopAnchor.constant = 50;
                         [self.view layoutIfNeeded];
                     }    completion:^(BOOL finished) {
                     }];
}

- (IBAction)addWaiter:(UIButton *)sender {
    Waiter *waiter = [self.dataManager generateWaiter];
    waiter.name = self.addWaiterTextField.text;
    [self.waiters addObject:waiter];
    waiter.restaurant = [[RestaurantManager sharedManager] currentRestaurant];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.waiters.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.dataManager saveContext];
    self.addWaiterTextField.text = @"";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Waiter *waiter = self.waiters[indexPath.row];
        [self.dataManager deleteObject:waiter];
        [self.waiters removeObject:waiter];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationTop];
        [self.dataManager saveContext];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShiftViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShiftViewController"];
    Waiter *waiter = self.waiters[indexPath.row];
    svc.waiter = waiter;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

@end
