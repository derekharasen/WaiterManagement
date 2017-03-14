//
//  AddShiftViewController.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "AddShiftViewController.h"
#import "RestaurantManager.h"
#import "Shift+CoreDataProperties.h"

@interface AddShiftViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *chooseDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *setStartTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *setEndTime;

@end

@implementation AddShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"Set Up Shift";

    if (self.shift != nil) {
        self.chooseDate.date = self.shift.date;
        self.setStartTime.date = self.shift.startTime;
        self.setEndTime.date = self.shift.endTime;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addShift:(UIBarButtonItem *)sender {
    if (self.shift == nil) {
    NSManagedObjectContext *context = [[RestaurantManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:context];
    NSFetchRequest *fetch = [Shift fetchRequest];
    [fetch setEntity:entity];
    
    Shift *newShift = [NSEntityDescription insertNewObjectForEntityForName:@"Shift" inManagedObjectContext:context];
    newShift.date = self.chooseDate.date;
    newShift.startTime = self.setStartTime.date;
    newShift.endTime = self.setEndTime.date;
    
    newShift.waiter = self.waiter;
    NSSet *shifts = [self.waiter.shift setByAddingObject:newShift];
    [self.waiter addShift:shifts];
    } else {
        self.shift.date = self.chooseDate.date;
        self.shift.startTime = self.setStartTime.date;
        self.shift.endTime = self.setEndTime.date;
    }
    [[RestaurantManager sharedManager] saveContext];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelAddShift:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)displayShiftView:(Waiter *)waiter {
    if (_waiter != waiter) {
        _waiter = waiter;
    }
}

- (void)displayShiftForEdit:(Shift *)shift {
    if (_shift != shift) {
        _shift = shift;
    }
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
