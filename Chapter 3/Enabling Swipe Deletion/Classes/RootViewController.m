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
@synthesize arrayOfRows;
@synthesize editButton;
@synthesize doneButton;

/* ------------------------------------------- */

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.myTableView] == YES){
    if (self.arrayOfRows != nil){
      /* Number of Rows that we have in total */
      result = [self.arrayOfRows count];
    }
  }
  
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
    result = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (result == nil){
      /* Could not get a reusable cell. Create one */
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:MyCellIdentifier] autorelease];
    } /* if (Result == nil){ */
    
    /* Set the main text of the cell, grab the text
     out of the array that we've already constructed */
    if (self.arrayOfRows != nil &&
        indexPath.row < [self.arrayOfRows count]){
      result.textLabel.text = 
      [self.arrayOfRows objectAtIndex:indexPath.row];
    }
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSInteger result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    /* We just have one section */
    result = 1;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void)              tableView:(UITableView*)tableView 
    didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    if (self.myTableView.editing == NO){
      [self performDone:nil];
    }
    
  }
  
}

/* ------------------------------------------- */

- (void)              tableView:(UITableView*)tableView
 willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    if (self.myTableView.editing == NO){
      [self performEdit:nil];
    }
    
  }
  
}

/* ------------------------------------------- */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = UITableViewCellEditingStyleDelete;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void)  tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
  forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    if (editingStyle == UITableViewCellEditingStyleDelete){
      if (self.arrayOfRows != nil &&
          indexPath.row < [self.arrayOfRows count]){
        /* First remove this object from the source */
        [self.arrayOfRows removeObjectAtIndex:indexPath.row];
        /* Then remove the associated cell from the Table View */
        [tableView 
         deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
         withRowAnimation:UITableViewRowAnimationLeft];
      } 
    }
  }
  
}

/* ------------------------------------------- */

- (void) performDone:(id)paramSender{
  
  [self.myTableView setEditing:NO
                      animated:YES];
  
  [self.navigationItem setRightBarButtonItem:self.editButton
                                    animated:YES];
  
}

/* ------------------------------------------- */

- (void) performEdit:(id)paramSender{
  
  [self.myTableView setEditing:YES
                      animated:YES];

  [self.navigationItem setRightBarButtonItem:self.doneButton
                                    animated:YES];
  
}

/* ------------------------------------------- */

- (void) initializeNavigationBarButtons{
  
  /* Give the user an Edit Button on the Navigation Bar */
  UIBarButtonItem *newEditButton = 
  [[UIBarButtonItem alloc] 
   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
   target:self
   action:@selector(performEdit:)];
  
  self.editButton = newEditButton;
  [newEditButton release];
  
  self.navigationItem.rightBarButtonItem = self.editButton;
  
  /* --------- */
  
  UIBarButtonItem *newDoneButton = 
  [[UIBarButtonItem alloc] 
   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
   target:self
   action:@selector(performDone:)];
  
  self.doneButton = newDoneButton;
  
  [newDoneButton release];
  
}

/* ------------------------------------------- */

- (void) initializeArrayOfRows{
  
  /* Put strings in array that will later be feeding our table */
  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
  self.arrayOfRows = mutableArray;
  [mutableArray release];
  
  NSUInteger rowCounter = 0;
  for (rowCounter = 0; rowCounter < 100; rowCounter++){
    
    NSString *rowText = 
    [NSString stringWithFormat:@"Row %lu", rowCounter];
    
    [self.arrayOfRows addObject:rowText];
  }
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initializeArrayOfRows];
  
  [self initializeNavigationBarButtons];
  
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
  self.arrayOfRows = nil;
  self.editButton = nil;
  self.doneButton = nil;
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* ------------------------------------------- */

- (void)dealloc {
  
  [self.myTableView release];
  [self.arrayOfRows release];
  [self.doneButton release];
  [self.editButton release];
  
  [super dealloc];
}

/* ------------------------------------------- */

@end
