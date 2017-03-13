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
    [self setTitle:@"Add Waiter"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addWaiter:(UIBarButtonItem*)sender {
    
    NSManagedObjectContext *context = [[RestaurantManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:context];
    NSFetchRequest *fetch = [Waiter fetchRequest];
    [fetch setEntity:entity]; 
    
    Waiter *newWaiter = [NSEntityDescription insertNewObjectForEntityForName:@"Waiter" inManagedObjectContext:context];
    newWaiter.name = self.addWaiterTextField.text;
    newWaiter.restaurant = [[RestaurantManager sharedManager] currentRestaurant];
    NSSet *waiters = [[[RestaurantManager sharedManager] currentRestaurant].staff setByAddingObject:newWaiter];
    [[[RestaurantManager sharedManager] currentRestaurant] addStaff:waiters];
    [[RestaurantManager sharedManager] saveContext];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
