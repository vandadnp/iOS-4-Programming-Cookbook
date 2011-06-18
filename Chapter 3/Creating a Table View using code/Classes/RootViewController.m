//
//  RootViewController.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright  2010. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

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
  
  /* Add this Table View to our View */
  [self.view addSubview:tableView];
  
  /* Release the allocated Table View. It is now retained
   by this View Controller's View */
  [tableView release];
  
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

