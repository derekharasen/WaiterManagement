//
//  SwiftViewController.swift
//  StaffManagement
//
//  Created by Alex Bearinger on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController, UITextFieldDelegate {

    var waiters = [Waiter]()
    let manager = RestaurantManager.sharedManager() as! RestaurantManager
    var nameTextField = UITextField()
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
        //    self.waiters = [[[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]] mutableCopy];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//static NSString * const kCellIdentifier = @"CellIdentifier";

//@property IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UITextField *nameTextField;        
//        - (IBAction)addWaiter:(id)sender {
//            if (self.nameTextField.text == nil){
//                return;
//            }
//            Waiter *newWaiter = [self.manager newWaiter:self.nameTextField.text];
//            if (newWaiter != nil){
//                [self.waiters addObject:newWaiter];
//                [self.tableView reloadData];
//            }
//            self.nameTextField.text = nil;
//}
//
//#pragma mark - TableView Data Source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//    }
//    
//    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//        return self.waiters.count;
//        }
//        
//        - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
//            Waiter *waiter = self.waiters[indexPath.row];
//            cell.textLabel.text = waiter.name;
//            return cell;
//            }
//            
//            - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                NSString *name = cell.textLabel.text;
//                if (name == nil){
//                    return;
//                }
//                self.manager.selected = [self.manager getWaiter:name];
//                [self performSegueWithIdentifier:@"Shifts" sender:self];
//                }
//                
//                - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//                    return YES;
//                    }
//                    
//                    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//                        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                        NSString *name = cell.textLabel.text;
//                        if (self.waiters.count > 0){
//                            Waiter *removedWaiter = [self.manager getWaiter:name];
//                            if(removedWaiter != nil){
//                                [self.waiters removeObject:removedWaiter];
//                                [self.tableView reloadData];
//                            }
//                        }
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//@end
