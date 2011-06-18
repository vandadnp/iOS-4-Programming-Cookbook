    //
//  RootViewController.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

/* ------------------------------------------- */

@synthesize myTableView;

/* ------------------------------------------- */

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  /* For each section, we will return a specific number of
   rows. This number can/will be different depending on the
   requirements of the project */
  
  if ([table isEqual:self.myTableView] == YES){
    switch (section){
      /* ---------------- */
      case 0:{
        /* Let's have 3 rows for the first section */
        result = 3;
        break;
      }
      /* ---------------- */
      case 1:{
        /* And 5 rows for the second */
        result = 5;
        break;
      }
      /* ---------------- */
      default:{
        /* And last but not least, let's create
         8 rows for the third section */
        result = 8;
      }
      /* ---------------- */
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void)                        tableView:(UITableView *)tableView 
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    UITableViewCell *ownerCell =  
    [tableView cellForRowAtIndexPath:indexPath];
    
    /* Do something with the cell which owns the button */
    NSLog(@"%@", ownerCell.textLabel.text);
  }
  
}

/* ------------------------------------------- */

- (void) performExpand:(UIButton *)paramSender{
  
  UITableViewCell *ownerCell = 
  (UITableViewCell*)paramSender.superview;
  
  if (ownerCell != nil){
    
    /* Now we will retrieve the index path of the cell 
     which contains the section and the row of the cell */
    
    NSIndexPath *ownerCellIndexPath = 
      [self.myTableView indexPathForCell:ownerCell];
    
    /* Now we can use these two values to truly determine that
     the accessory button of which cell was the sender of this event:
     
     OwnerCellIndexPath.section
     OwnerCellIndexPath.row
     
    */
    
    if (ownerCellIndexPath.section == 0 &&
        ownerCellIndexPath.row == 1){
      /* This is the second row in the first section */
    }
    
    /* And so forth with the other checks ... */
  
  }
    
}
  
/* ------------------------------------------- */

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell* result = nil;
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    static NSString *MyCellIdentifier = @"SimpleCell";
    
    /* We will try to retrieve an existing cell 
     with the given identifier */
    result = [tableView 
              dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (result == nil){
      /* If a cell with the given identifier does not
       exist, we will create the cell with the
       identifier and hand it to the table view */
      
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:MyCellIdentifier] autorelease];
    }
    
    result.textLabel.text = 
    [NSString stringWithFormat:@"Section %lu, Cell %lu", 
     (unsigned long)indexPath.section, 
     (unsigned long)indexPath.row];
    
    UIButton *button = 
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0.0, 0.0, 150.0, 25.0);
    
    [button setTitle:@"Expand" 
            forState:UIControlStateNormal];
    
    [button addTarget:self 
               action:@selector(performExpand:) 
     forControlEvents:UIControlEventTouchUpInside];
    
    result.accessoryView = button;
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  NSInteger Result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    /* For now, let's just create 3 sections in our 
     Table View for the sake of simplicity in this example.
     We can increase or decrease this value. Each one
     of the sections will have a number of rows in it,
     determined with the datasource's
     [tableView:numberOfRowsInSection:] method */
    Result = 3;
  }
  
  return(Result);
}

/* ------------------------------------------- */

- (void)        tableView:(UITableView *)tableView 
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    self.title = 
    [NSString 
     stringWithFormat:@"Cell %lu in Section %lu is selected", 
     (unsigned long)indexPath.row, 
     (unsigned long)indexPath.section];
  }
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Our Table View, in this example, will fill the area
   of the whole view */
  CGRect TableViewRect = self.view.frame;
  
  UITableView *tableView = [[UITableView alloc] 
                            initWithFrame:TableViewRect
                            style:UITableViewStylePlain];
  
  self.myTableView = tableView;
  
  [tableView release];
  
  /* Make sure our Table View adjusts its 
   width/height/left/top spaces whenever its container
   view changes its orientation or size */
  self.myTableView.autoresizingMask = 
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
  
  /* Add our Table View to our view and also make the current
   View Controller the datasource of the Table View.
   The datasource could be any other object though 
   and doesn't necessarily have to be a View Controller */
  
  [self.view addSubview:self.myTableView];
  
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
