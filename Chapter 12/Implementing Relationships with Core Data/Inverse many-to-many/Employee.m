//
//  Employee.m
//  Data
//
//  Created by Vandad Nahavandipoor on 11-03-30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Employee.h"
#import "Manager.h"


@implementation Employee
@dynamic firstName;
@dynamic age;
@dynamic lastName;
@dynamic FKEmployeeToManagers;

- (void)addFKEmployeeToManagersObject:(Manager *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"FKEmployeeToManagers"] addObject:value];
    [self didChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFKEmployeeToManagersObject:(Manager *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"FKEmployeeToManagers"] removeObject:value];
    [self didChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addFKEmployeeToManagers:(NSSet *)value {    
    [self willChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"FKEmployeeToManagers"] unionSet:value];
    [self didChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeFKEmployeeToManagers:(NSSet *)value {
    [self willChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"FKEmployeeToManagers"] minusSet:value];
    [self didChangeValueForKey:@"FKEmployeeToManagers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
