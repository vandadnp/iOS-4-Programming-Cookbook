//
//  RootViewController.m
//  Contacts
//
//  Created by Vandad Nahavandipoor on 10-07-20.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


/* ------------------------------- */

- (ABRecordRef) createNewPersonWithFirstName:(NSString *)paramFirstName 
                lastName:(NSString *)paramLastName
                inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  ABRecordRef result = nil;
  
  /* Check the address book parameter */
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(nil);
  }
  
  /* Just create an empty person entry */
  ABRecordRef person = ABPersonCreate();
  
  if (person == nil){
    NSLog(@"Failed to create a new person.");
    return(nil);
  }
  
  BOOL couldSetFirstName = NO;
  BOOL couldSetLastName = NO;
  CFErrorRef error = nil;
  
  /* Set the first name of the person */
  couldSetFirstName = 
  ABRecordSetValue(person,
                   kABPersonFirstNameProperty, 
                   paramFirstName,
                   &error);
  
  /* Set the last name of the person */
  couldSetLastName =
  ABRecordSetValue(person, 
                   kABPersonLastNameProperty, 
                   paramLastName, 
                   &error);
  
  if (couldSetFirstName == YES &&
      couldSetLastName == YES){
    NSLog(@"Successfully set the first and the last name.");
    
    /* Add the person record to the address book. We have NOT saved yet */
    if (ABAddressBookAddRecord(paramAddressBook, 
                               person,
                               &error) == YES){
      NSLog(@"Successfully added the new person.");
      
      /* Now save the address book if there are any unsaved changes */
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &error) == YES){
        
        NSLog(@"Successfully saved the address book.");
        
        result = person;
        
      } else {
        /* Either no unsaved changes were there or we could not save the
         address book */
      }
      
    } else {
      NSLog(@"Could not add a new person.");
    }
    
  } else {
    NSLog(@"Either the first or the last name could not be set.");
  }
  
  return(result);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    ABRecordRef newPerson = 
    [self createNewPersonWithFirstName:@"Leonardo"
                              lastName:@"DiCaprio"
                         inAddressBook:addressBook];
    
    if (newPerson != nil){
      NSLog(@"Successfully added the new person");
      
      CFRelease(newPerson);
      
    } else {
      NSLog(@"Insertion failed");
    }
    
    CFRelease(addressBook);
    
  } /* if (addressBook != nil){ */
  
}

/* ------------------------------- */


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [super dealloc];
}


@end
