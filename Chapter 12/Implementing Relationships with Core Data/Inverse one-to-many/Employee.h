//
//  Employee.h
//  Data
//
//  Created by Vandad Nahavandipoor on 11-03-30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Manager;

@interface Employee : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) Manager * FKEmployeeToManager;

@end
