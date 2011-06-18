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

- (BOOL)    addPerson:(ABRecordRef)paramPerson 
              toGroup:(ABRecordRef)paramGroup
    saveToAddressBook:(ABAddressBookRef)paramAddressBook{
  
  BOOL result = NO;
  
  if (paramPerson == nil ||
      paramGroup == nil ||
      paramAddressBook == nil){
    NSLog(@"Invalid parameters are given.");
    return(NO);
  }
  
  CFErrorRef error = nil;
  
  /* Now attempt to add the person entry to the group */
  result = ABGroupAddMember(paramGroup,
                            paramPerson,
                            &error);
  
  if (result == NO){
    NSLog(@"Could not add the person to the group.");
    return(NO);
  }
  
  /* Make sure we save any unsaved changes */
  if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
      ABAddressBookSave(paramAddressBook, &error) == YES){
    NSLog(@"Successfully added the person to the group.");
    result = YES;
  } else {
    NSLog(@"No changes were saved.");
  }
  
  return(result);
  
}

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
  CFErrorRef Error = nil;
  
  /* Set the first name of the person */
  couldSetFirstName =
  ABRecordSetValue(person,
                   kABPersonFirstNameProperty, 
                   paramFirstName,
                   &Error);
  
  /* Set the last name of the person */
  couldSetLastName = 
  ABRecordSetValue(person, 
                   kABPersonLastNameProperty, 
                   paramLastName, 
                   &Error);
  
  if (couldSetFirstName == YES &&
      couldSetLastName == YES){
    NSLog(@"Successfully set the first and the last name.");
    
    /* Add the person record to the address book. 
     We have NOT saved yet */
    if (ABAddressBookAddRecord(paramAddressBook,
                               person, 
                               &Error) == YES){
      NSLog(@"Successfully added the new person.");
      
      /* Now save the address book if there are any unsaved changes */
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &Error) == YES){
        
        NSLog(@"Successfully saved the address book.");
        
        result = person;
        
      } else {
        /* Either no unsaved changes were there or 
         we could not save the address book */
      }
      
    } else {
      NSLog(@"Could not add a new person to the address book.");
    }
    
  } else {
    NSLog(@"Either the first or the last name could not be set.");
  }
  
  return(result);
  
}

/* ------------------------------- */

- (ABRecordRef) createNewGroupWithName:(NSString *)paramGroupName 
                inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  ABRecordRef result = nil;
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
  }
  
  ABRecordRef group = ABGroupCreate();
  
  if (group == nil){
    NSLog(@"Failed to create a new group.");
    return(nil);
  }
  
  BOOL couldSetGroupName = NO;
  CFErrorRef error = nil;
  
  couldSetGroupName =
  ABRecordSetValue(group, 
                   kABGroupNameProperty, 
                   paramGroupName,
                   &error);
  
  if (couldSetGroupName == YES){
    
    if (ABAddressBookAddRecord(paramAddressBook, 
                               group, 
                               &error) == YES){
      NSLog(@"Successfully added the new group.");
      
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &error) == YES){
        
        NSLog(@"Successfully saved the address book.");
        
        result = group;
        
      } else {
        /* Either no unsaved changes were there or 
         we could not save the address book */
      }
      
    } else {
      NSLog(@"Could not add a new group.");
    }
    
  } else {
    NSLog(@"Failed to set the name of the group.");
  }
  
  return(result);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    ABRecordRef leonardoDiCaprio = 
    [self createNewPersonWithFirstName:@"Leonardo"
                              lastName:@"DiCaprio"
                         inAddressBook:addressBook];
    
    if (leonardoDiCaprio != nil){
      
      ABRecordRef hollywoodGroup = 
      [self createNewGroupWithName:@"Hollywood"
                     inAddressBook:addressBook];
      
      if (hollywoodGroup != nil){
        
        if ([self addPerson:leonardoDiCaprio
                    toGroup:hollywoodGroup
          saveToAddressBook:addressBook] == YES){
          NSLog(@"Successfully added the person to the group.");
        } else {
          NSLog(@"Could not add the user to the group.");
        }
        
        CFRelease(hollywoodGroup);
        
      } else {
        NSLog(@"Could not create the group.");
      }
      
      CFRelease(leonardoDiCaprio);
      
    } else {
      NSLog(@"The new person was not created.");
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
