//
//  AddShiftViewController.m
//  StaffManagement
//
//  Created by Carl Udren on 9/11/16.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import "AddShiftViewController.h"
#import "Shift+CoreDataProperties.h"
#import "AppDelegate.h"

@interface AddShiftViewController ()

@property (nonatomic, strong) Waiter *waiter;
@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UITextField *startTextField;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UITextField *endTextField;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) UIDatePicker *endPicker;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation AddShiftViewController

#pragma mark - Initialization

- (instancetype) initWithWaiter: (Waiter *) waiter {
    self = [super init];
    _waiter = waiter;
    return self;
}

#pragma mark - VC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareDateFormatter];
    [self prepareBackground];
    [self prepareNavigationItem];
    [self prepareStartLabel];
    [self prepareStartTextField];
    [self prepareEndLabel];
    [self prepareEndTextField];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.startTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Preparation code
- (void) prepareDateFormatter {
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMM d, yyyy - h:mm a";
}

- (void) prepareBackground {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) prepareNavigationItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (UILabel *) buildLabel: (NSString *) text  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor darkGrayColor];
    label.text = text;
    return label;
}

- (UITextField *) buildTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleBezel;
    textField.textColor = [UIColor darkGrayColor];
    
    return textField;
}

- (void) prepareStartLabel {
    self.startLabel = [self buildLabel:@"Start Time"];
    [self.view addSubview:self.startLabel];
}

- (void) prepareEndLabel {
    self.endLabel = [self buildLabel:@"End Time"];
    [self.view addSubview:self.endLabel];
}

- (void) prepareStartTextField {
    self.startTextField = [self buildTextField];
    UIDatePicker *inputView = [[UIDatePicker alloc] init];
    [inputView addTarget:self action:@selector(startPickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.startTextField.inputView = inputView;
    [self.view addSubview: self.startTextField];
}

- (void) prepareEndTextField {
    self.endTextField = [self buildTextField];
    UIDatePicker *inputView = [[UIDatePicker alloc] init];
    [inputView addTarget:self action:@selector(endPickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.endPicker = inputView;
    self.endTextField.inputView = inputView;
    [self.view addSubview: self.endTextField];
}

#pragma mark - Layout

- (void) viewDidLayoutSubviews {
    [self layoutStartLabel];
    [self layoutStartTextField];
    [self layoutEndLabel];
    [self layoutEndTextField];
}

- (void) layoutStartLabel {
    CGFloat navBarMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.startLabel.frame = CGRectMake(30, navBarMaxY + 30, self.view.bounds.size.width - 60, 30);
}

- (void) layoutStartTextField {
    self.startTextField.frame = CGRectMake(30, CGRectGetMaxY(self.startLabel.frame), self.view.bounds.size.width - 60, 30);
}

- (void) layoutEndLabel {
    self.endLabel.frame = CGRectMake(30, CGRectGetMaxY(self.startTextField.frame) + 30, self.view.bounds.size.width - 60, 30);
}

- (void) layoutEndTextField {
    self.endTextField.frame = CGRectMake(30, CGRectGetMaxY(self.endLabel.frame), self.view.bounds.size.width - 60, 30);
}
#pragma mark - BarButton Handlers

- (void) save {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *shiftEntity = [NSEntityDescription entityForName:@"Shift" inManagedObjectContext:appDelegate.managedObjectContext];
    Shift *newShift = [[Shift alloc] initWithEntity:shiftEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    newShift.startTime = self.startTime;
    newShift.endTime = self.endTime;
    [self.waiter addShiftObject: newShift];
    
    [appDelegate saveContext];
    
    [self.startTextField resignFirstResponder];
    [self.endTextField resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) cancel {
    [self.startTextField resignFirstResponder];
    [self.endTextField resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate

- (void) startPickerChanged: (UIDatePicker *) sender {
    self.startTextField.text = [self.formatter stringFromDate:sender.date];
    self.startTime = sender.date;
    self.endPicker.minimumDate = sender.date;
}

- (void) endPickerChanged: (UIDatePicker *) sender {
    self.endTextField.text = [self.formatter stringFromDate:sender.date];
    self.endTime = sender.date;
    [self checkSaveShouldEnable];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.startTextField resignFirstResponder];
    [self.endTextField resignFirstResponder];
    [self checkSaveShouldEnable];
}

- (void) checkSaveShouldEnable {
    if (self.startTime != nil && self.endTime != nil) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

@end
