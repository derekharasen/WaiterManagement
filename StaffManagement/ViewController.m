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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]] mutableCopy];
    [self.tableView reloadData];
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

#pragma mark - TableView editing (delete row)

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //Get Managed Object Context from AppDelegate
        id delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        
        // Delete object from database/handle error
        [context deleteObject:[self.waiters objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove waiter from table view
        [self.waiters removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Add Waiter

- (IBAction)addWaiterButton:(UIButton *)sender {
    
    // Create Alert Controller to add waiter
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Add Waiter"
                                  message:@"What is the waiter's name?"
                                  preferredStyle:UIAlertControllerStyleAlert
                                  ];
    
    UIAlertAction* addButton = [UIAlertAction
                                actionWithTitle:@"Add"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self addWaiter: alert.textFields[0].text];
                                    
                                }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler: nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter Name Here";
    }];
    [alert addAction:addButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma - Helper functions

- (void)addWaiter:(NSString *)waiterName {
    
    // Handle empty textfield exception, else save to Core Data
    
    if ([waiterName isEqualToString:@""]){
        UIAlertController *emptyTextFieldAlert =[UIAlertController alertControllerWithTitle:@"Error"
                                                                                    message:@"No name was entered."
                                                                             preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [emptyTextFieldAlert addAction:cancelButton];
        [self presentViewController:emptyTextFieldAlert animated:YES completion:nil];
    }else{
    
        // Create a new managed object
        id delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        
        NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:context];
        Waiter *newWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:context];
        
        // Add waiter to current restaurant
        newWaiter.name = NSLocalizedString(waiterName, nil);
        [[[RestaurantManager sharedManager]currentRestaurant]  addStaffObject:newWaiter];

        // Save the object to Core Data
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        // Modify local waiters array, update table
        [self.waiters addObject:newWaiter];
        
        NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.waiters = [[self.waiters sortedArrayUsingDescriptors:@[sortByName]] mutableCopy];
        
        [self.tableView reloadData];
    }
}

@end