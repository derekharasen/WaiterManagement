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
#import "AddShiftViewController.h"
#import "ShiftTableViewCell.h"
#import "Shift+CoreDataProperties.h"
#import "StaffManagement-Swift.h"

@interface AddWaiterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addWaiterTextField;
@property (weak, nonatomic) IBOutlet UIButton *addShiftOutlet;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *shiftsLabel;

@property (nonatomic, retain) NSMutableArray *shiftsArray;

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

- (void)viewWillAppear:(BOOL)animated {
    NSManagedObjectContext *context = [[RestaurantManager sharedManager] appDelegate].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shift" inManagedObjectContext:context];
    NSFetchRequest *fetch = [Shift fetchRequest];
    [fetch setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetch error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    NSMutableArray *temp = [NSMutableArray new];
    for (Shift *shift in fetchedObjects) {
        if (shift.waiter == self.waiter) {
            [temp addObject:shift];
        }
    }
    self.shiftsArray = temp;
    
    NSSortDescriptor *sortByShiftDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *tempArray = [self.waiter.shift sortedArrayUsingDescriptors:@[sortByShiftDate]];
    self.shiftsArray = [tempArray mutableCopy];
    
    [self.tableView reloadData];
}

- (void)displayEditView:(Waiter *)waiter {
    if (_waiter != waiter) {
        _waiter = waiter;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons

- (IBAction)addWaiter:(UIBarButtonItem*)sender {
    
    if (self.waiter == nil) {
        NSManagedObjectContext *context = [[RestaurantManager sharedManager] appDelegate].managedObjectContext;
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
    [[[RestaurantManager sharedManager] appDelegate] saveContext];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelAddWaiter:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddShift"]) {
        UINavigationController *nav = [segue destinationViewController];
        ShiftViewController *addShiftVC = nav.viewControllers[0];
        addShiftVC.waiter = self.waiter;
        [addShiftVC displayShiftViewWithWaiter:addShiftVC.waiter];
    }
    
    if ([segue.identifier isEqualToString:@"EditShift"]) {
        UINavigationController *nav = [segue destinationViewController];
        ShiftViewController *addShiftVC = nav.viewControllers[0];
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        addShiftVC.shift = self.shiftsArray[indexPath.row];
        [addShiftVC dispalyShiftForEditWithShift:addShiftVC.shift];
    }
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shiftsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Shift *shift = self.shiftsArray[indexPath.row];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSDateFormatter *timeFormatterStart = [NSDateFormatter new];
    NSDateFormatter *timeFormatterEnd = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    [timeFormatterStart setDateFormat:@"hh:mm a"];
    [timeFormatterEnd setDateFormat:@"hh:mm a"];
    
    NSString *dateString = [dateFormatter stringFromDate:shift.date];
    NSString *timeStringStart = [timeFormatterStart stringFromDate:shift.startTime];
    NSString *timeStringEnd = [timeFormatterEnd stringFromDate:shift.endTime];
    
    cell.dateLabel.text = dateString;
    cell.startTimeLabel.text = timeStringStart;
    cell.endTimeLabel.text = timeStringEnd;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"EditShift" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[RestaurantManager sharedManager] appDelegate].managedObjectContext deleteObject:self.shiftsArray[indexPath.row]];
        [[[RestaurantManager sharedManager] appDelegate] saveContext];
        [self.shiftsArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

@end
