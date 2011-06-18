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

- (void)            tableView:(UITableView *)tableView 
           moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
                  toIndexPath:(NSIndexPath *)destinationIndexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    /* First get the row's title out of our array */
    NSString *sourceObject = 
    [[self.arrayOfRows objectAtIndex:sourceIndexPath.row] retain];
    
    /* Now remove the string from where it was before. This is
     the source index path */
    [self.arrayOfRows removeObjectAtIndex:sourceIndexPath.row];
    
    /* And insert the same string into the destination row */
    [self.arrayOfRows insertObject:sourceObject
                          atIndex:destinationIndexPath.row];
    
    /* Make sure we release the retained string */
    [sourceObject release];
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
}

/* ------------------------------------------- */

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//  /* When we are moving the cells around, we do not want to have
//   any deletion or insertion styles for our cells */
//  
//  UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    /* You can customize this value here. We return 
//     UITableViewCellEditingStyleNone for this table
//     view like other table views that we might be managing
//     at this time */
//  }
//  
//  return(result);
//  
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//  UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    result = UITableViewCellEditingStyleDelete;
//  }
//  
//  return(result);
//  
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = UITableViewCellEditingStyleInsert;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

//- (void)  tableView:(UITableView *)tableView 
// commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
//  forRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    if (editingStyle == UITableViewCellEditingStyleDelete){
//      if (self.arrayOfRows != nil &&
//          indexPath.row < [self.arrayOfRows count]){
//        /* First remove this object from the source */
//        [self.arrayOfRows removeObjectAtIndex:indexPath.row];
//        /* Then remove the associated cell from the Table View */
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                         withRowAnimation:UITableViewRowAnimationLeft];
//      } 
//    }
//  }
//  
//}

- (void)  tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
  forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.myTableView] == YES){
    if (editingStyle == UITableViewCellEditingStyleInsert){
      
      /* We want to insert a new cell into the row after the
       cell that has fired this event */
      indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1
                                     inSection:indexPath.section];
      
      /* Insert a new value into the source */
      [self.arrayOfRows insertObject:@"New Cell" 
                             atIndex:indexPath.row];
      
      /* And eventually insert a new row into the Table View */
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationMiddle];
      
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
  
  /* Put strings in an array that will later be feeding our table */
  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
  self.arrayOfRows = mutableArray;
  [mutableArray release];
  
  NSUInteger rowCounter = 0;
  for (rowCounter = 0; rowCounter < 100; rowCounter++){
    NSString *rowText = [NSString stringWithFormat:@"Row %lu", 
                         (unsigned long)rowCounter];
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
