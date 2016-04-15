//
//  ShiftsViewController.h
//  StaffManagement
//
//  Created by Daniel Hooper on 2016-04-14.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ShiftsViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObject *detailItem;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
