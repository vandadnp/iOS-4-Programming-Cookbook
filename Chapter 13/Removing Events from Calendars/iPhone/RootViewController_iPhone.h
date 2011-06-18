//
//  RootViewController_iPhone.h
//  Test
//
//  Created by Vandad Nahavandipoor on 10-07-28.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

/* ----------------------------------- */

@interface RootViewController_iPhone : UIViewController 
           <UITableViewDataSource, UITableViewDelegate> {
@public
  /* The table view that will contain the event cells */
  UITableView     *tableViewEvents;
  /* The array that will contain all the event objects */
  NSMutableArray  *arrayOfEvents;
  /* And the event store that we will use to fetch
   and delete events */
  EKEventStore    *eventStore;
             
  UIBarButtonItem *editButton;
  UIBarButtonItem *doneButton;
}

/* ----------------------------------- */

@property (nonatomic, retain) 
IBOutlet UITableView *tableViewEvents;

@property (nonatomic, retain) 
NSMutableArray       *arrayOfEvents;

@property (nonatomic, retain) 
EKEventStore         *eventStore;

@property (nonatomic, retain)
UIBarButtonItem      *editButton;

@property (nonatomic, retain) 
UIBarButtonItem      *doneButton;

/* ----------------------------------- */

/* This method will display the Edit button on the top left
 corner of the navigation bar */
- (void) displayNormalNavigationItems;

/* This method will remove the edit button and will
 display a Done button on the top right corner of
 the navigation bar */
- (void) displayEditingNavigationItems;

/* ----------------------------------- */

@end
