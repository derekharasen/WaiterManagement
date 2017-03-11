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

@interface ViewController ()
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *waiters;
@property RestaurantManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)addWaiter:(id)sender {
    if (self.waiters.count > 0){
        [self.manager saveWaiter:@"New Waiter"];
        [self.tableView reloadData];
    }
}

- (IBAction)removeWaiter:(id)sender {
    if (self.waiters.count > 0){
        if([self.manager removeWaiter:self.waiters[0]]){
            [self.waiters removeObject:self.waiters[0]];
        }
    }
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
    [self performSegueWithIdentifier:@"Shifts" sender:self];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Shifts"]){
        
    }
}

@end
