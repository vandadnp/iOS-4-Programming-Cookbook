//
//  RootViewController_iPhone.h
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-25.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Person.h"

/* ------------------------------------------- */

@interface RootViewController_iPhone : UIViewController 
           <UITableViewDelegate, UITableViewDataSource, 
            NSFetchedResultsControllerDelegate> {
@public
  UITableView  *tableViewPersons;
  NSFetchedResultsController  *personsFRC;
  UIBarButtonItem *doneButton;
  UIBarButtonItem *addButton;
  UIBarButtonItem *editButton;
}

/* ------------------------------------------- */

@property (nonatomic, retain) 
IBOutlet UITableView  *tableViewPersons;

@property (nonatomic, retain)
NSFetchedResultsController  *personsFRC;

@property (nonatomic, retain) 
UIBarButtonItem *doneButton;

@property (nonatomic, retain) 
UIBarButtonItem *addButton;

@property (nonatomic, retain)
UIBarButtonItem *editButton;

/* ------------------------------------------- */

- (BOOL) readAllPersons;
- (void) setDefaultNavigationBarButtons;
- (void) setEditingModeNavigationBarButtons;

/* ------------------------------------------- */

@end