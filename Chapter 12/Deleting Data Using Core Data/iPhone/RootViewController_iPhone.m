//
//  RootViewController_iPhone.m
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-25.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController_iPhone.h"
#import "AppDelegate_Shared.h"
#import "AddNewPersonViewController_iPhone.h"

/* ------------------------------------------- */

@implementation RootViewController_iPhone

/* ------------------------------------------- */

@synthesize tableViewPersons;
@synthesize arrayOfPersons;
@synthesize editButton;
@synthesize doneButton;
@synthesize addButton;

/* ------------------------------------------- */

#pragma mark -
#pragma mark === Table View Delegate ===
#pragma mark -

/* ------------------------------------------- */

- (void)              tableView:(UITableView*)tableView 
 willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    if (self.tableViewPersons.editing == NO){
      [self setEditingModeNavigationBarButtons];
    }
  }
  
}

/* ------------------------------------------- */

- (void)              tableView:(UITableView*)tableView 
    didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    if (self.tableViewPersons.editing == NO){
      [self setDefaultNavigationBarButtons];
    }
  }
  
}

/* ------------------------------------------- */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
  editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCellEditingStyle result =
  UITableViewCellEditingStyleNone;
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    /* Allow the user to delete items from the table while we are
     in the editing mode */
    result = UITableViewCellEditingStyleDelete;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

#pragma mark -
#pragma mark === Table View Data Source ===
#pragma mark -

/* ------------------------------------------- */

- (void)  tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    
    /* Only allow deletion in the editing mode */
    if (editingStyle != UITableViewCellEditingStyleDelete){
      return;
    }
    
    /* Make sure our array contains the item that is about to
     be deleted from the table view */
    if ([self.arrayOfPersons count] <= indexPath.row){
      return;
    }
    
    /* Get the person that has to be deleted from the array */
    Person *thisPerson = 
    [self.arrayOfPersons objectAtIndex:indexPath.row];
    
    AppDelegate_Shared *delegate = (AppDelegate_Shared *)
    [[UIApplication sharedApplication] delegate];
    
    /* Attempt to delete the person from the context */
    [delegate.managedObjectContext deleteObject:thisPerson];
    
    /* And we also have to save the context after deletion */
    NSError *savingError = nil;
    if ([delegate.managedObjectContext save:&savingError] == YES){
      
      /* Remove the person from the array and also make sure that
       we remove the corresponding cell from the table 
       preferrably with an animation */
      
      [self.arrayOfPersons removeObject:thisPerson];
      
      NSArray *cellsToDelete = [NSArray arrayWithObject:indexPath];
      
      [tableView 
       deleteRowsAtIndexPaths:cellsToDelete
       withRowAnimation:UITableViewRowAnimationFade];
      
    } else {
      /* An error happened here */
    }
    
  }
  
}

/* ------------------------------------------- */

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.tableViewPersons] == YES){
    
    if (self.arrayOfPersons != nil){
      /* The number of cells we have is exactly equal 
       to the number of Person managed objects 
       that we have in our array */
      result = [self.arrayOfPersons count];
    }
    
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *result = nil;
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    
    static NSString *SimpleIdentifier = @"PersonCell";
    
    result = 
    [tableView 
     dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    /* A cell with sub title */
    if (result == nil){
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:SimpleIdentifier] autorelease];
    }
    
    if (self.arrayOfPersons != nil){
      
      
      Person *thisPerson = 
      [self.arrayOfPersons objectAtIndex:indexPath.row];
      
      /* The title will be "Last Name, First Name" */
      
      result.textLabel.text = 
      [NSString stringWithFormat:@"%@, %@",
       thisPerson.lastName,
       thisPerson.firstName];
      
      /* The sub title will be the age */
      
      result.detailTextLabel.text = 
      [NSString stringWithFormat:@"Age %ld",
       (long)[thisPerson.age integerValue]];
      
      result.selectionStyle =
      UITableViewCellSelectionStyleNone;
      
    }
    
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSInteger result = 0;
  
  if ([tableView isEqual:self.tableViewPersons] == YES){
    /* We only have one section */
    result = 1;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

#pragma mark -
#pragma mark === Instance Methods ===
#pragma mark -

/* ------------------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  if ((self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil])) {
    
    self.title = NSLocalizedString(@"Persons", nil);
    /* Make sure we instantiate this array */
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    arrayOfPersons = [newArray retain];
    [newArray release];
    
  }
  
  return(self);
}

/* ------------------------------------------- */

- (BOOL) readAllPersons{
  
  BOOL result = NO;
  
  if (self.arrayOfPersons == nil){
    return(NO);
  }
  
  AppDelegate_Shared *delegate = (AppDelegate_Shared *)
  [[UIApplication sharedApplication] delegate];
  
  NSManagedObjectContext *context = delegate.managedObjectContext;
  
  /* Find the Person entity in the context */
  NSEntityDescription *personEntity = 
  [NSEntityDescription entityForName:@"Person"
              inManagedObjectContext:context];
  
  /* Now we want to read all the data in the Person entity */
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  [request setEntity:personEntity];
  
  NSError *fetchError = nil;
  
  /* Do the fetching here */
  NSArray *persons = [context executeFetchRequest:request
                                            error:&fetchError];
  
  /* Make sure we could read the data */
  if (persons != nil){
    
    /* Add all the persons from the array to our array */
    [self.arrayOfPersons removeAllObjects];
    [self.arrayOfPersons addObjectsFromArray:persons];
    [self.tableViewPersons reloadData];
    result = YES;
    
  }
  
  [request release];
  request = nil;
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) performAddNewPerson:(id)paramSender{
  
  /* Just display the Add New Person View Controller */
  
  AddNewPersonViewController_iPhone *controller = 
  [[AddNewPersonViewController_iPhone alloc] 
   initWithNibName:@"AddNewPersonViewController_iPhone"
   bundle:nil];
  
  [self.navigationController pushViewController:controller
                                       animated:YES];
  
  [controller release];
  
}

/* ------------------------------------------- */

- (void) performDoneEditing:(id)paramSender{
  
  /* Take the table view out of the editing mode and re-create
   the default navigation bar buttons */
  
  [self.tableViewPersons setEditing:NO
                           animated:YES];
  
  [self setDefaultNavigationBarButtons];
  
}

/* ------------------------------------------- */

- (void) performEditTable:(id)paramSender{
  
  /* Take the table to the editing mode */
  [self setEditingModeNavigationBarButtons];
  
  [self.tableViewPersons setEditing:YES
                           animated:YES];
  
}

/* ------------------------------------------- */

- (void) viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  /* Make sure we read the array of all the people in the
   managed object context and reload our table with
   the latest data. If in the Add New Person 
   View Controller, we actually do add a person and
   come back to this screen, our table view will refresh 
   itself automatically this way */
  
  [self readAllPersons];
}

/* ------------------------------------------- */

- (void) setEditingModeNavigationBarButtons{
  
  /* In the editing mode, we just want a Done button on the
   top left hand corder of the navigation bar to take the
   table view out of the editing mode */
  
  [self.navigationItem setLeftBarButtonItem:self.doneButton
                                    animated:YES];
  
  [self.navigationItem setRightBarButtonItem:nil
                                   animated:YES];
  
}

/* ------------------------------------------- */

- (void) setDefaultNavigationBarButtons{
  
  /* Here we set an add button (+) on the top right and
   an edit button on the top left that will take our table
   view into editing mode where the user can delete items from
   the table and our managed object context */
  
  [self.navigationItem setRightBarButtonItem:self.addButton
                                    animated:YES];
  
  [self.navigationItem setLeftBarButtonItem:self.editButton
                                   animated:YES];
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
  UIBarButtonItem *newAddButton = 
  [[UIBarButtonItem alloc]
   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
   target:self
   action:@selector(performAddNewPerson:)];
  self.addButton = newAddButton;
  [newAddButton release];
  
  UIBarButtonItem *newEditButton =
  [[UIBarButtonItem alloc]
   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
   target:self
   action:@selector(performEditTable:)];
  self.editButton = newEditButton;
  [newEditButton release];
  
  UIBarButtonItem *newDoneButton = 
  [[UIBarButtonItem alloc]
   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
   target:self
   action:@selector(performDoneEditing:)];
  self.doneButton = newDoneButton;
  [newDoneButton release];
  
  [self setDefaultNavigationBarButtons];
  
  self.tableViewPersons.rowHeight = 60.0f;
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  /* Free up some memory space */
  
  self.tableViewPersons = nil;
  self.arrayOfPersons = nil;
  self.editButton = nil;
  self.doneButton = nil;
  self.addButton = nil;
  
  self.navigationItem.rightBarButtonItem = nil;
  self.navigationItem.leftBarButtonItem = nil;
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ------------------------------------------- */

- (void)dealloc {
  
  [arrayOfPersons release];
  [tableViewPersons release];
  [editButton release];
  [doneButton release];
  [addButton release];
  
  [super dealloc];
}

/* ------------------------------------------- */

@end
