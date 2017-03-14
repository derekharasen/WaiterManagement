//
//  AddWaiterViewController.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "AddWaiterViewController.h"
#import "RestaurantManager.h"
#import "AppDelegate.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface AddWaiterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addWaiterTextField;
@property (weak, nonatomic) IBOutlet UIButton *addShiftOutlet;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *shiftsLabel;

@property (nonatomic) NSMutableArray *shifts;

@end

@implementation AddWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(addWaiter:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAddWaiter:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [self setTitle:@"Add Waiter"];
    self.tableView.hidden = YES;
    self.addShiftOutlet.hidden = YES;
    self.shiftsLabel.hidden = YES;
    
    if (self.waiter != nil) {
        [self setTitle:@"Edit Waiter"];
        self.addWaiterTextField.text = self.waiter.name;
        self.tableView.hidden = NO;
        self.addShiftOutlet.hidden = NO;
        self.shiftsLabel.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addWaiter:(UIBarButtonItem*)sender {
    
    if (self.waiter == nil) {
        NSManagedObjectContext *context = [[RestaurantManager sharedManager] managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:context];
        NSFetchRequest *fetch = [Waiter fetchRequest];
        [fetch setEntity:entity];
        
        Waiter *newWaiter = [NSEntityDescription insertNewObjectForEntityForName:@"Waiter" inManagedObjectContext:context];
        newWaiter.name = self.addWaiterTextField.text;
        newWaiter.restaurant = [[RestaurantManager sharedManager] currentRestaurant];
        NSSet *waiters = [[[RestaurantManager sharedManager] currentRestaurant].staff setByAddingObject:newWaiter];
        [[[RestaurantManager sharedManager] currentRestaurant] addStaff:waiters];
    } else {
        self.waiter.name = self.addWaiterTextField.text;
    }
    [[RestaurantManager sharedManager] saveContext];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelAddWaiter:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)displayDetailView:(Waiter *)waiter {
    if (_waiter != waiter) {
        _waiter = waiter;
    }
}

- (IBAction)addShift:(UIButton *)sender {
    
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shifts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    return cell;
}




@end
