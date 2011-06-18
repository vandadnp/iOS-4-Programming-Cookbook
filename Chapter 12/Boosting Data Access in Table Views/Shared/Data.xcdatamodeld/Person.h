//
//  Person.h
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-24.
//  Copyright 2010 Pixolity Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Person :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * lastName;

@end



