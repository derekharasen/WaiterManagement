//
//  ShiftViewController.m
//  StaffManagement
//
//  Created by Patrick Whitehead on 2015-03-16.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ShiftsViewController.h"
#import "AddShiftViewController.h"
#import "RestaurantManager.h"
#import "Shift.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@interface ShiftsViewController ()
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *shifts;
@end

@implementation ShiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.waiter.name;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Shifts";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:YES];
    self.shifts = [NSMutableArray arrayWithArray:[self.waiter.shifts sortedArrayUsingDescriptors:@[sortByDate]]];
    
    [self.tableView reloadData];
}


- (void)add{
    
    AddShiftViewController *addShiftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddShiftViewController"];
    addShiftViewController.waiter = self.waiter;
    [self.navigationController pushViewController:addShiftViewController animated:YES];
}


#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiter.shifts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Shift *shift = [self.shifts objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    NSString *dateString = [formatter stringFromDate:shift.date];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@-%@",dateString, shift.start, shift.end];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Shift *shift = [self.shifts objectAtIndex:indexPath.row];
        RestaurantManager *restaurantManager = [RestaurantManager sharedManager];
        [restaurantManager deleteShift:shift];
        
        //remove from tableview
        [self.shifts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
