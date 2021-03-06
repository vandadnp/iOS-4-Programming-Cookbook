//
//  AppDelegate_Shared.m
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-24.
//  Copyright 2010  All rights reserved.
//

#import "AppDelegate_Shared.h"
#import "Person.h"

@implementation AppDelegate_Shared

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

/* ------------------------------------------- */

- (BOOL) createNewPersonWithFirstName:(NSString *)paramFirstName
                             lastName:(NSString *)paramLastName
                                  age:(NSUInteger)paramAge{
  
  BOOL result = NO;
  
  /* First create an instance of Person in the context. At this point
   the new Person object has not been inserted into the database */
  Person *newPerson = 
  [NSEntityDescription 
   insertNewObjectForEntityForName:@"Person"
   inManagedObjectContext:self.managedObjectContext];
  
  /* Make sure we created an instance correctly */
  if (newPerson != nil){
    NSLog(@"Successfully created a new person.");
    
    /* Change the properties if we want to */
    newPerson.age = [NSNumber numberWithInteger:paramAge];
    newPerson.firstName = paramFirstName;
    newPerson.lastName = paramLastName;
    
    /* And eventually save any unsaved changes into the context */
    NSError *savingError = nil;
    if ([self.managedObjectContext save:&savingError] == YES){
      NSLog(@"Successfully saved the new person.");
      result = YES;
    } else {
      NSLog(@"Failed to save the new person.");
    }
    
  } else {
    NSLog(@"Failed to create a new person.");
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  [self createNewPersonWithFirstName:@"Foo"
                            lastName:@"Foo Last Name"
                                 age:25];
  
  [self createNewPersonWithFirstName:@"Baz"
                            lastName:@"Baz Last Name" 
                                 age:29];
  
  
  /* Create the fetch request first */
  NSFetchRequest *fetchRequest = 
  [[NSFetchRequest alloc] init];
  
  /* Here is the entity whose contents we want to read */
  NSEntityDescription *entity = 
  [NSEntityDescription 
   entityForName:@"Person"
   inManagedObjectContext:self.managedObjectContext];
  
  /* Tell the request that we want to read the
   contents of the Person entity */
  [fetchRequest setEntity:entity];
  
  NSError *requestError = nil;
  
  /* And execute the fetch request on the context */
  NSArray *persons = 
  [self.managedObjectContext 
   executeFetchRequest:fetchRequest 
   error:&requestError];
  
  /* Make sure we get the array */
  if ([persons count] > 0){
    
    /* Go through the persons array one by one */
    NSUInteger counter = 1;
    for (Person *thisPerson in persons){
      
      NSLog(@"Person %lu First Name = %@", 
            (unsigned long)counter, 
            thisPerson.firstName);
      
      NSLog(@"Person %lu Last Name = %@", 
            (unsigned long)counter, 
            thisPerson.lastName);
      
      NSLog(@"Person %lu Age = %ld", 
            (unsigned long)counter, 
            (long)[thisPerson.age integerValue]);
      
      counter++;
    }
    
  } else {
    NSLog(@"Failed to read the array of persons.");
  }
  
  /* Make sure to release the fetch request we allocated previously */
  [fetchRequest release];
  
  return(YES);
  
}

/* ------------------------------------------- */


/**
 Save changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    
    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Data.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [window release];
    [super dealloc];
}


@end

