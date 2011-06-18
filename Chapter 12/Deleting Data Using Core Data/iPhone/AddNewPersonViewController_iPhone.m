//
//  AddNewPersonViewController_iPhone.m
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-25.
//  Copyright 2010  All rights reserved.
//

#import "AddNewPersonViewController_iPhone.h"
#import "AppDelegate_Shared.h"

/* ------------------------------------------- */

@implementation AddNewPersonViewController_iPhone

/* ------------------------------------------- */

@synthesize textFieldFirstName;
@synthesize textFieldLastName;
@synthesize textFieldAge;
@synthesize doneButton;
@synthesize saveButton;

/* ------------------------------------------- */

- (void) performDone:(id)paramSender{
  [self.textFieldAge resignFirstResponder];
  [self.textFieldFirstName resignFirstResponder];
  [self.textFieldLastName resignFirstResponder];
  
  [self setDefaultNavigationBarButtons];
}

/* ------------------------------------------- */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
  
  BOOL result = YES;
  
  /* Make sure we create the Done button on the top
   right hand side of the navigation bar when we are
   editing the contents of our text fields */
  
  if (self.editing == NO){
    [self setEditingModeNavigationBarButtons];
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  if ((self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil])) {
    
    self.title = NSLocalizedString(@"Add New Person", nil);
    
  }
  
  return self;
}

/* ------------------------------------------- */

- (void) displayAlertWithTitle:(NSString *)paramTitle
                       message:(NSString *)paramMessage{
  
  /* Simply create and display an alert view using
   the title and the message given to us */
  UIAlertView *alertView = 
  [[[UIAlertView alloc]
    initWithTitle:paramTitle
    message:paramMessage
    delegate:nil
    cancelButtonTitle:NSLocalizedString(@"OK", nil)
    otherButtonTitles:nil, nil] autorelease];
  
  [alertView show];
  
}

/* ------------------------------------------- */

- (void)  performAddNewPerson:(id)paramSender{
  
  AppDelegate_Shared *delegate = (AppDelegate_Shared *)
  [[UIApplication sharedApplication] delegate];
  
  NSManagedObjectContext *context = delegate.managedObjectContext;
  
  /* Get the values from the text fields */
  NSString *firstName = self.textFieldFirstName.text;
  
  NSString *lastName = self.textFieldLastName.text;
  
  NSInteger ageAsInteger = [self.textFieldAge.text integerValue];
  NSNumber *age = [NSNumber numberWithInteger:ageAsInteger];
  
  /* Create a new instance of Person */
  Person *newPerson = [NSEntityDescription 
                       insertNewObjectForEntityForName:@"Person"
                       inManagedObjectContext:context];
  
  if (newPerson != nil){
    
    /* Set the properties according to the values
     we retrieved from the text fields */
    
    newPerson.firstName = firstName;
    newPerson.lastName = lastName;
    newPerson.age = age;
    
    NSError *savingError = nil;
    
    /* Save the new person */
    if ([context save:&savingError] == YES){
      /* If successful, simply go back to the previous screen */
      [self.navigationController popViewControllerAnimated:YES];
    } else {
      /* If we failed to save, display a message */
      [self
       displayAlertWithTitle:NSLocalizedString(@"Saving", nil) 
       message:NSLocalizedString(@"Failed to save the context", nil)];
    }
    
  } else {
    /* We could not insert a new Person managed object */
    [self 
     displayAlertWithTitle:NSLocalizedString(@"New Person", nil)
     message:NSLocalizedString(@"Failed To Insert A New Person", nil)];
  }
  
}

/* ------------------------------------------- */

- (void) setDefaultNavigationBarButtons{
  
  /* By default, we have to have a Save button on the top
   right hand side of the navigation bar */
  
  [self.navigationItem setRightBarButtonItem:self.saveButton
                                    animated:YES];
  
  [self setEditing:NO];
  
}

/* ------------------------------------------- */

- (void) setEditingModeNavigationBarButtons{
  
  /* When editing the text fields, we will replace the
   Save button with a Done button that will resign all
   text fields from being the first responder just
   so that the keyboard (if shown) will be hidden */
  
  [self.navigationItem setRightBarButtonItem:self.doneButton
                                    animated:YES];
  
  [self setEditing:YES];
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *newDoneButton = 
  [[UIBarButtonItem alloc]
   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
   target:self
   action:@selector(performDone:)];
  self.doneButton = newDoneButton;
  [newDoneButton release];

  UIBarButtonItem *newSaveButton = 
  [[UIBarButtonItem alloc] 
   initWithTitle:NSLocalizedString(@"Save", nil)
   style:UIBarButtonItemStylePlain
   target:self
   action:@selector(performAddNewPerson:)];
  self.saveButton = newSaveButton;
  [newSaveButton release];
  
  [self setDefaultNavigationBarButtons];
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  /* Give up some memory used by our text fields
   in case of low memory */
  
  self.textFieldAge = nil;
  self.textFieldFirstName = nil;
  self.textFieldLastName = nil;
  self.doneButton = nil;
  self.saveButton = nil;
  
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
  [textFieldFirstName release];
  [textFieldLastName release];
  [textFieldAge release];
  [doneButton release];
  [saveButton release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
