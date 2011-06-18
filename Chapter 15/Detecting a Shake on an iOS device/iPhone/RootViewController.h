//
//  RootViewController.h
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

/* ----------------------------------- */

@interface RootViewController : UIViewController 
           <UITableViewDelegate, UITableViewDataSource> {
@public
  NSMutableArray  *arrayOfShakeDateAndTimes;
  UITableView     *tableViewShakes;
}

/* ----------------------------------- */

@property (nonatomic, retain)
IBOutlet UITableView     *tableViewShakes;

@property (nonatomic, copy) 
NSMutableArray  *arrayOfShakeDateAndTimes;

/* ----------------------------------- */

@end
