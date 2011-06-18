//
//  Manager.m
//  Data
//
//  Created by Vandad Nahavandipoor on 11-03-30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Manager.h"
#import "Employee.h"


@implementation Manager
@dynamic firstName;
@dynamic age;
@dynamic lastName;
@dynamic FKManagerToEmployees;

- (void)addFKManagerToEmployeesObject:(Employee *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"FKManagerToEmployees"] addObject:value];
    [self didChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFKManagerToEmployeesObject:(Employee *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"FKManagerToEmployees"] removeObject:value];
    [self didChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addFKManagerToEmployees:(NSSet *)value {    
    [self willChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"FKManagerToEmployees"] unionSet:value];
    [self didChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeFKManagerToEmployees:(NSSet *)value {
    [self willChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"FKManagerToEmployees"] minusSet:value];
    [self didChangeValueForKey:@"FKManagerToEmployees" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
