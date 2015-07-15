//
//  ShiftsTableViewController.m
//  StaffManagement
//
//  Created by Kunwardeep Gill on 2015-07-15.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ShiftsTableViewController.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Shift.h"

@interface ShiftsTableViewController ()

@property (retain, nonatomic) NSArray *shiftsList;

@end

@implementation ShiftsTableViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc]initWithKey:@"startDate" ascending:YES];
    
    self.shiftsList = [self.waiter.shifts sortedArrayUsingDescriptors:@[sortByDate]];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegate


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


//  Swipe to Delete
- (void)tableView:(UITableView * )tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * )indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSError *error;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        
        Shift *shift = self.shiftsList [indexPath.row];
        [appDelegate.managedObjectContext deleteObject:self.shiftsList[indexPath.row]];
        
        Waiter *aWaiter;
        aWaiter = self.waiter;
        
        [aWaiter removeShiftsObject:shift];
        [appDelegate.managedObjectContext save:&error];
        
        NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc]initWithKey:@"startDate" ascending:YES];
        self.shiftsList = [self.waiter.shifts sortedArrayUsingDescriptors:@[sortByDate]];
        
        [self.tableView reloadData];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.shiftsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Shift *aShift = self.shiftsList[indexPath.row];
    cell.textLabel.text = aShift.startDate;
    cell.detailTextLabel.text = aShift.endDate;
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"newShift"]) {
        ShiftsTableViewController *destViewController = segue.destinationViewController;
        destViewController.waiter = self.waiter;
    }
}

@end
