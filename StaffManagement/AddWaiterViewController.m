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
    
//    Waiter *newWaiter = [[NSEntityDescription insertNewObjectForEntityForName:@"Waiter" inManagedObjectContext:[RestaurantManager sharedManager]
    
    NSManagedObjectContext *context = [[RestaurantManager sharedManager] appDelegate].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:context];
    NSFetchRequest *fetch = [Waiter fetchRequest];
    [fetch setEntity:entity];
    
    Waiter *newWaiter = [NSEntityDescription insertNewObjectForEntityForName:@"Waiter" inManagedObjectContext:[self getContext]];
    newWaiter.name = self.addWaiterTextField.text;
    self.waiter.restaurant = [[RestaurantManager sharedManager] restaurant];
    [[[RestaurantManager sharedManager] currentRestaurant] addStaffObject:newWaiter];
    [[[RestaurantManager sharedManager] appDelegate] saveContext];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Core Data Methods

- (NSManagedObjectContext *)getContext {
    return [self getContainer].viewContext;
}

- (NSPersistentContainer *)getContainer{
    return [self appDelegate].persistentContainer;
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
