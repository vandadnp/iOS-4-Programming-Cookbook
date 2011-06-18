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
@synthesize personsFRC;
@synthesize doneButton;
@synthesize addButton;
@synthesize editButton;

/* ------------------------------------------- */

#pragma mark -
#pragma mark === Fetched Results Controller Delegate ===
#pragma mark -

/* ------------------------------------------- */

- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath 
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath{
  
  [self.tableViewPersons reloadData];
  
}

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
    /* Allow the user to delete items from the
     table while we are in the editing mode */
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
    
    /* Get the person that has to be deleted from the array */
    Person *thisPerson = 
    [self.personsFRC objectAtIndexPath:indexPath];
    
    AppDelegate_Shared *delegate = (AppDelegate_Shared *)
    [[UIApplication sharedApplication] delegate];
    
    /* Attempt to delete the person from the context */
    [delegate.managedObjectContext deleteObject:thisPerson];
    
    /* And we also have to save the context after deletion */
    NSError *savingError = nil;
    if ([delegate.managedObjectContext 
         save:&savingError] == YES){
      
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
    
    if (self.personsFRC != nil){
      
      /* find the corresponding section in 
       the Fetched Results Controller */
      
      id<NSFetchedResultsSectionInfo> thisSection = 
      [self.personsFRC.sections objectAtIndex:section];
      
      /* And get the number of managed objects that are
       present in this section */
      result = [thisSection numberOfObjects];
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
    
    if (self.personsFRC != nil){
      
      Person *thisPerson = 
      [self.personsFRC objectAtIndexPath:indexPath];
      
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
    if (self.personsFRC != nil){
      result = [self.personsFRC.sections count];
    }
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
    
  }
  
  return self;
}

/* ------------------------------------------- */

- (BOOL) readAllPersons{
  
  BOOL result = NO;
  
  if (self.personsFRC != nil){
    return(NO);
  }
    
  AppDelegate_Shared *delegate = (AppDelegate_Shared *)
  [[UIApplication sharedApplication] delegate];
  
  NSManagedObjectContext *context = 
  delegate.managedObjectContext;
  
  /* Find the Person entity in the context */
  NSEntityDescription *personEntity = 
  [NSEntityDescription entityForName:@"Person"
              inManagedObjectContext:context];
  
  NSSortDescriptor *ageSortDescriptor =
  [[NSSortDescriptor alloc] initWithKey:@"age"
                              ascending:YES];
  
  NSSortDescriptor *firstNameSortDescriptor =
  [[NSSortDescriptor alloc] initWithKey:@"firstName"
                              ascending:YES];
  
  NSArray *sortDescriptors = [NSArray arrayWithObjects:
                              ageSortDescriptor,
                              firstNameSortDescriptor,
                              nil];
  
  [firstNameSortDescriptor release];
  [ageSortDescriptor release];
    
  /* Now we want to read all the data in the Person entity */
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  /* set the entity of the request */
  [request setEntity:personEntity];
  
  /* And sort by age and then first name */
  [request setSortDescriptors:sortDescriptors];
  
  /* keep only 20 managed objects in the memory */
  [request setFetchBatchSize:20];
  
  NSFetchedResultsController *newFRC = 
  [[NSFetchedResultsController alloc]
   initWithFetchRequest:request
   managedObjectContext:context
   sectionNameKeyPath:nil
   cacheName:@"PersonsCache"];
  
  /* Create the fetched results controller */
  self.personsFRC = newFRC;
  [newFRC release];
  
  /* whenever the fetched results controller (FRC) 
   changes, meaning that a managed object inside 
   it for instance gets deleted or modified, we will
   get notified and eventually we will reflect
   the changes in the  GUI */
  self.personsFRC.delegate = self;
  
  NSError *fetchError = nil;
  /* Make sure to perform a fetch in order 
   to read the managed objects */
  result = [self.personsFRC performFetch:&fetchError];
  
  [request release];
  
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
  
  /* Take the table view out of the editing mode and reset
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
}

/* ------------------------------------------- */

- (void) setEditingModeNavigationBarButtons{
  
  /* In the editing mode, we just want a Done button on the
   top left hand corder of the navigation bar to take the
   table view out of the editing mode */
  
  [self.navigationItem setRightBarButtonItem:nil
                                   animated:YES];
  
  [self.navigationItem setLeftBarButtonItem:self.doneButton
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
  [self readAllPersons];
  
  self.tableViewPersons.rowHeight = 60.0f;
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  /* Free up some memory space */
  
  
  self.tableViewPersons = nil;
  self.personsFRC = nil;
  self.addButton = nil;
  self.editButton = nil;
  self.doneButton = nil;
  
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
  
  [personsFRC release];
  [tableViewPersons release];
  [doneButton release];
  [addButton release];
  [editButton release];
  
  [super dealloc];
}

/* ------------------------------------------- */

@end
