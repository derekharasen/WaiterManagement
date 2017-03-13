//
//  ShiftsViewController.m
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-11.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "ShiftsViewController.h"
#import "RestaurantManager.h"
#import "Waiter.h"

@interface ShiftsViewController ()
@property (nonatomic) NSSet *shifts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RestaurantManager *manager;
@end

@implementation ShiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [RestaurantManager sharedManager];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    Waiter *waiter = self.manager.selected;
    self.shifts = waiter.shifts;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender {
    NSError *error = nil;
    if (![self.manager.managedContext save:&error]){
        NSLog(@"Error ! %@", error.localizedDescription);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shifts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    Waiter *waiter = self.waiters[indexPath.row];
//    cell.textLabel.text = waiter.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
