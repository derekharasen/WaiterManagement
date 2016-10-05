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
#import "AppDelegate.h"
#import "WaiterManager.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray <NSManagedObject *> *waiters;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) WaiterManager *waiterManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *sortedArray = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    self.waiters = [NSMutableArray arrayWithArray:sortedArray];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.waiterManager = [WaiterManager new];
    //allows waiters to be mutable
    //self.waiters = [self.waiterManager updateWaiterList];
    [self.tableView reloadData];
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
    NSManagedObject *waiter = self.waiters[indexPath.row];
    cell.textLabel.text = [waiter valueForKey:@"name"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //get waiter to be deleted
        NSManagedObject *waiterToBeDeleted = [self.waiters objectAtIndex:indexPath.row];
        //delete waiter
        [self.waiterManager deleteWaiter:waiterToBeDeleted];
        
        // Remove waiter from table view
        [self.waiters removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    }
}

//method to add new waiter using an alert with a textfield
-(IBAction)addWaiter:(id)sender {
    
    //create alert
    UIAlertController* saveNameAlert = [UIAlertController alertControllerWithTitle:@"New Waiter"
                                                                   message:@"Add a new name"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    //create and add cancel button to alert
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //dismiss alert without saving anything
                                                              [self dismissViewControllerAnimated:saveNameAlert completion:nil];
                                                          }];
    
    [saveNameAlert addAction:cancelAction];
    
    //create and add save button to alert
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * saveAction) {
                                                         //save name, reload table and dismiss alert
                                                         NSString *name = saveNameAlert.textFields.firstObject.text;
                                                         [self.waiterManager saveWaiter:name];
                                                         self.waiters = [self.waiterManager updateWaiterList];
                                                         [self.tableView reloadData];
                                                         [self dismissViewControllerAnimated:saveNameAlert completion:nil];
                                                     }];
    
    [saveNameAlert addAction:saveAction];
    
    //add name textfield to alert
        [saveNameAlert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"First and Last Name", @"Name");
     }];
    
    //present alert
    [self presentViewController:saveNameAlert animated:YES completion:nil];
    
}

-(void)setUpNavBar {
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //creates 'add' button in navigation bar
    UIBarButtonItem *addWaiterButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Add"
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(addWaiter:)];
    self.navigationItem.rightBarButtonItem = addWaiterButton;

}

@end
