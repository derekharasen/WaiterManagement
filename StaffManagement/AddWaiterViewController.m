//
//  AddWaiterViewController.m
//  StaffManagement
//
//  Created by Daniel Hooper on 2016-04-14.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import "AddWaiterViewController.h"
#import "Waiter.h"
#import "Restaurant.h"
#import "RestaurantManager.h"

@interface AddWaiterViewController ()

@property (strong, nonatomic) UITextField *textField;

@end

@implementation AddWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Textfield
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake((0 + self.view.frame.size.width * 0.25) / 2, self.view.center.y, self.view.frame.size.width * 0.75, 30)];
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    // Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.center.y - 30, self.view.frame.size.width, 30)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Please enter a name"];
    [self.view addSubview:label];
    
    // Save Button
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setFrame:CGRectMake(self.view.frame.size.width - 100, 30, 100, 30)];
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveButton setTintColor:[UIColor blueColor]];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(saveButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    // Cancel Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(0, 30, 100, 30)];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelButton setTintColor:[UIColor blueColor]];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveButtonPressed {
    NSManagedObjectContext *context = self.managedObjectContext;

    Restaurant *restaurant = [[RestaurantManager sharedManager]currentRestaurant];
    
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:context];
    Waiter *waiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:context];
    waiter.name = self.textField.text;
    
    [restaurant addStaffObject:waiter];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
