//
//  RootViewController.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright  2010. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

/* ------------------------------------------- */

@implementation RootViewController

/* ------------------------------------------- */

@synthesize myTableView;

/* ------------------------------------------- */

- (CGFloat)     tableView:(UITableView *)tableView 
  heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  CGFloat result = 20.0f;
  
  /* ------------- */
  if ([tableView isEqual:self.myTableView]){
    result = 40.0f;
  }
  /* ------------- */
  
  return(result);
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* We want a full-screen Table View which is as
   big as the View which is attached to the current
   View Controller */
  CGRect tableViewFrame = self.view.bounds;
  
  /* Create the Table View First */
  UITableView *tableView = [[UITableView alloc] 
                            initWithFrame:tableViewFrame 
                            style:UITableViewStylePlain];

  self.myTableView = tableView;
  self.myTableView.delegate = self;
  
  /* Release the allocated Table View */
  [tableView release];  
  
  /* Add this Table View to our View */
  [self.view addSubview:tableView];
  
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  
  self.myTableView = nil;
  
}

/* ------------------------------------------- */

- (void)dealloc {
  [myTableView release];
  [super dealloc];
}

/* ------------------------------------------- */

@end

