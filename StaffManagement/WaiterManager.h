//
//  NSObject+WaiterManager.h
//  StaffManagement
//
//  Created by Rosalyn Kingsmill on 2016-09-30.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface WaiterManager: NSObject

-(void)saveWaiter:(NSString*)name;
-(void)deleteWaiter:(NSManagedObject*)waiter;
-(NSMutableArray*)updateWaiterList;

@end
