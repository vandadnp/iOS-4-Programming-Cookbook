//
//  RootViewController.h
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ------------------------------------------- */

@interface RootViewController : UIViewController 
                                <UITableViewDataSource, 
                                 UITableViewDelegate> {
@public
  UITableView     *myTableView;
  NSMutableArray  *arrayOfRows;
  UIBarButtonItem *editButton;
  UIBarButtonItem *doneButton;
}

/* ------------------------------------------- */

@property (nonatomic, retain) UITableView     *myTableView;
@property (nonatomic, retain) NSMutableArray  *arrayOfRows;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *doneButton;

/* ------------------------------------------- */

- (void) performEdit:(id)paramSender;
- (void) performDone:(id)paramSender;

/* ------------------------------------------- */

@end
