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

@interface AddWaiterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addWaiterTextField;

@end

@implementation AddWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(addWaiter:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAddWaiter:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [self setTitle:@"Add Waiter"];
    
    if (self.waiter != nil) {
        [self setTitle:@"Edit Waiter"];
        self.addWaiterTextField.text = self.waiter.name;
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

@end
