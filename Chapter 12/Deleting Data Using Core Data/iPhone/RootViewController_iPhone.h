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
           <UITableViewDelegate, UITableViewDataSource> {
@public
  UITableView     *tableViewPersons;
  NSMutableArray  *arrayOfPersons;
  UIBarButtonItem *editButton;
  UIBarButtonItem *doneButton;
  UIBarButtonItem *addButton;
}

/* ------------------------------------------- */

@property (nonatomic, retain) 
IBOutlet UITableView  *tableViewPersons;

@property (nonatomic, retain)
NSMutableArray  *arrayOfPersons;

@property (nonatomic, retain)
UIBarButtonItem *editButton;

@property (nonatomic, retain) 
UIBarButtonItem *doneButton;

@property (nonatomic, retain) 
UIBarButtonItem *addButton;

/* ------------------------------------------- */

- (BOOL) readAllPersons;
- (void) setDefaultNavigationBarButtons;
- (void) setEditingModeNavigationBarButtons;

/* ------------------------------------------- */

@end