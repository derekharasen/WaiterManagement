//
//  Restaurant+CoreDataProperties.m
//  StaffManagement
//
//  Created by Chris Jones on 2017-03-13.
//  Copyright © 2017 Derek Harasen. All rights reserved.
//

#import "Restaurant+CoreDataProperties.h"

@implementation Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Restaurant"];
}

@dynamic name;
@dynamic staff;

@end
