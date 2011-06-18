//
//  RootViewController.h
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ------------------------------------------- */

@interface RootViewController : UIViewController <UITableViewDataSource, 
                                                  UITableViewDelegate> {
@public
  UITableView     *myTableView;
}

/* ------------------------------------------- */

@property (nonatomic, retain) UITableView     *myTableView;

/* ------------------------------------------- */

@end
