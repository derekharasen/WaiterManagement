//
//  NewShiftViewController.m
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-12.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "NewShiftViewController.h"
#import "Waiter.h"
#import "Shift.h"
#import "StaffManagement-Swift.h"


@interface NewShiftViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@end

@implementation NewShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButton:(id)sender {
    RestaurantManager *manager = [RestaurantManager sharedManager];
    Waiter *waiter = manager.selected;
    NSEntityDescription *shiftEntity = [NSEntityDescription entityForName:@"Shift" inManagedObjectContext:manager.managedContext];
    Shift *shift = [[Shift alloc] initWithEntity:shiftEntity insertIntoManagedObjectContext:manager.managedContext];
    shift.start = self.startDate.date;
    shift.end = self.endDate.date;
    shift.waiter = waiter;
    [waiter addShiftsObject:shift];
    NSError *error = nil;
    if (![manager.managedContext save:&error]){
        NSLog(@"Error ! %@", error.localizedDescription);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
