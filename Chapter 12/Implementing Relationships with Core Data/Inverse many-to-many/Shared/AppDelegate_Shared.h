//
//  AppDelegate_Shared.h
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-24.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/* ------------------------------------------- */

@interface AppDelegate_Shared : NSObject <UIApplicationDelegate> {
@public
  UIWindow *window;
@private
  NSManagedObjectContext *managedObjectContext_;
  NSManagedObjectModel *managedObjectModel_;
  NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

/* ------------------------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/* ------------------------------------------- */

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

/* ------------------------------------------- */

@end

