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
    NSArray *temp = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    self.waiters = [temp mutableCopy];
    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.waiters removeObjectAtIndex:indexPath.row];
        [[[RestaurantManager sharedManager] managedObjectContext] deleteObject:self.waiters[indexPath.row]];
        [tableView reloadData];
        [[[RestaurantManager sharedManager] appDelegate] saveContext];
    }
}

- (IBAction)addWaiter:(UIBarButtonItem *)sender {
    
    
    [[[RestaurantManager sharedManager] appDelegate] saveContext];
}


//#pragma mark - Core Data Methods
//
//- (NSManagedObjectContext *)getContext {
//    return [self getContainer].viewContext;
//}

//- (NSPersistentContainer *)getContainer{
//    return [RestaurantManager sharedManager].persistentStoreCoordinator;
//}

@end
