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
    
    ABRecordRef hollywoodGroup = 
    [self createNewGroupWithName:@"Hollywood"
                   inAddressBook:addressBook];
    
    if (hollywoodGroup != nil){
      NSLog(@"Successfully created the group.");
      
      CFRelease(hollywoodGroup);
      
    } else {
      NSLog(@"Could not create the group.");
    }
    
    CFRelease(addressBook);
    
  }
  
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
