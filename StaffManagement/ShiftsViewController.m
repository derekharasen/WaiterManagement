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
#import "ShiftsTableViewCell.h"

@interface ShiftsViewController ()
@property (nonatomic) NSMutableArray *shifts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RestaurantManager *manager;
@end

@implementation ShiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [RestaurantManager sharedManager];   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
     Waiter *waiter = self.manager.selected;
     self.shifts = [NSMutableArray arrayWithArray:[waiter.shifts allObjects]];
    [self.tableView reloadData];
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
    ShiftsTableViewCell *cell = (ShiftsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Shift *shift = self.shifts[indexPath.row];
    cell.startDateLabel.text = [NSString stringWithFormat:@"Start: %@",[self shiftDate:shift.start]];
    cell.endDateLabel.text = [NSString stringWithFormat:@"End: %@",[self shiftDate:shift.end]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Shift *shift = self.shifts[indexPath.row];
    if ([self.manager removeShift:shift]){
        [self.shifts removeObject:shift];
        [self.tableView reloadData];
    }
}

-(NSString*)shiftDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *newDateString = [dateFormatter stringFromDate:date];
    return newDateString;
}

@end
