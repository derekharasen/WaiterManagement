//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "AppDelegate.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "AddWaiterViewController.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSArray *waiters;
@end

@implementation ViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
    [self prepareNavigationItems];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateWaiters];
    [self.tableView reloadData];
}

- (void) updateWaiters {
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Preparation Methods
- (void) prepareTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(void) prepareNavigationItems {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushNewWaiterVC)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView)];
    self.navigationItem.title = @"Waiters";
}

#pragma mark - Layout

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTableView];
}

- (void) layoutTableView {
    CGRect viewRect = self.view.bounds;
    self.tableView.frame = CGRectMake(0, 0, viewRect.size.width, viewRect.size.height);
}

#pragma mark - Navigation

- (void) pushNewWaiterVC {
    
    [self.tableView setEditing:NO animated:YES];
    
    AddWaiterViewController *vc = [[AddWaiterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:true completion:nil];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //will push waiter vc to add shifts
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Waiter *waiter = self.waiters[indexPath.row];
        
        [tableView beginUpdates];
        [self deleteWaiter: waiter];
        [self updateWaiters];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}

#pragma mark - TableView editing

- (void) editTableView {
    self.tableView.isEditing ? [self.tableView setEditing:NO animated:YES] : [self.tableView setEditing:YES animated:YES];
}

- (void) deleteWaiter: (Waiter *) waiter {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    [context deleteObject:waiter];
    [appDelegate saveContext];
}

@end
