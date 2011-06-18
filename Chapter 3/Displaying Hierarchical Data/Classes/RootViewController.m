//
//  RootViewController.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ------------------------------------------- */

@implementation RootViewController

/* ------------------------------------------- */

@synthesize myTableView;

/* ------------------------------------------- */

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForHeaderInSection:(NSInteger)section{
    
  CGFloat result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = 40.0f;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForFooterInSection:(NSInteger)section{
  
  CGFloat result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = 40.0f;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.myTableView] == YES){
    
    switch (section){
      case 0:{
        result = 2;
        break;
      }
      case 1:{
        result = 5;
        break;
      }
      default:{
        result = 8;
        break;
      }
    }
    
  } /* if ([table isEqual:self.TableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell* result = nil;
  
  /* Reusable identifier of our cells */
  static NSString *MyCellIdentifier = @"SimpleCells";
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    /* Can we reuse the cells */
    result = (UITableViewCell *)
    [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (result == nil){
      /* Could not get a reusable cell. Create one */
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:MyCellIdentifier] autorelease];
    } /* if (Result == nil){ */
    
    result.textLabel.text = 
    [NSString stringWithFormat:@"Section %lu, Cell %lu",
     (unsigned long)indexPath.section,
     (unsigned long)indexPath.row];
    
    result.indentationLevel = indexPath.row;
    result.indentationWidth = 10.0f;
        
  } /* if ([tableView isEqual:self.TableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSInteger result = 0;

  if ([tableView isEqual:self.myTableView] == YES){
    /* We just have one section */
    result = 4;
  } /* if ([tableView isEqual:self.TableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = [[UITableView alloc] 
                            initWithFrame:self.view.bounds 
                            style:UITableViewStylePlain];
  
  self.myTableView = tableView;
  
  [tableView release];
  
  self.myTableView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
  
  [self.view addSubview:self.myTableView];
  
  /* This View Controller is both the Data Source
   and the Delegate of the Table View */
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;

  
}

/* ------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  self.myTableView = nil;
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* ------------------------------------------- */

- (void)dealloc {

  [myTableView release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
