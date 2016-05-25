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

static NSString * const kCellIdentifier = @"CellIdentifier";

typedef void(^completion)(NSString *);

@interface ViewController()
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *waiters;
@end

@implementation ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
  self.waiters = [[[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]] mutableCopy];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self prepareView];
  NSLog(@"Number of rows at viewDidLoad: %ld",(long)self.waiters.count);
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
#pragma mark - Preparation
- (void)prepareView{
  //Set Navigation Controller Title
  [self.navigationItem setTitle:@"Staff Management"];
  
  // Add buttons on the nav bar
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add)];
  self.navigationItem.rightBarButtonItem = addButton;
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
}
#pragma mark - Actions
-(void)Add{
  //Display alert controller and ask for text
  [self alertControllerTextInputWithTitle:@"Add staff"
                              withMessage:@"Please enter the name of the new waiter"
                               completion:^(NSString * name) {
                                 if (name != nil && ![name isEqualToString:@""] ){
                                   [self insertWaiter:name];
                                 }
                               }];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
  [super setEditing:editing animated:animated];
  [self.tableView setEditing:editing animated:YES];
}
#pragma mark - Helper
-(void)insertWaiter:(NSString *)name{
  Waiter *addedWaiter = [[RestaurantManager sharedManager] addWaiter:NSLocalizedString(name,nil)];
  if (addedWaiter){
    [self.waiters addObject:addedWaiter];
    NSInteger row = self.waiters.count - 1;
    NSLog(@"Number for rows: %ld",(long)row);
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0 ]] withRowAnimation:UITableViewRowAnimationTop];
  } else{
    [self alertControllerWithTitle:@"Error"
                       withMessage:@"Unable to add staff"];
  }
}
-(void)deleteWaiterAtIndexPath:(NSIndexPath*)indexPath{
  //Delete from Core Data
  if ([[RestaurantManager sharedManager] deleteWaiter:self.waiters[indexPath.row]]){
    //Delete from Array
    [self.waiters removeObjectAtIndex:indexPath.row];
    //Delete from Table View
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else{
    [self alertControllerWithTitle:@"Error"
                       withMessage:@"Unable to delete staff"];
  }
}
-(void)alertControllerTextInputWithTitle:(NSString *)title withMessage:(NSString *)message completion:(completion) completionBlock{
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
  //Add a text field in the alert
  [alertController addTextFieldWithConfigurationHandler:nil];
  
  //Ok action
  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionBlock(alertController.textFields.firstObject.text);
  }];
  //Cancel action
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  
  //Add actions
  [alertController addAction:okAction];
  [alertController addAction:cancelAction];
  
  [alertController.view setNeedsDisplay];
  
  [self presentViewController:alertController
                     animated:YES
                   completion:nil];
}
-(void)alertControllerWithTitle:(NSString *)title withMessage:(NSString *)message{
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
  //Ok action
  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
  
  //Add actions
  [alertController addAction:okAction];
  
  [self presentViewController:alertController
                     animated:YES
                   completion:nil];
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

#pragma mark - TableView Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self deleteWaiterAtIndexPath:indexPath];
  }
}
@end
