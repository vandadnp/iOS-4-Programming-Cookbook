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

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    /* Work with the address book here */
    
    /* Let's see if we have made any changes to the
     address book or not, before attempting to save it */
    
    if (ABAddressBookHasUnsavedChanges(addressBook) == YES){
      /* Now decide if you want to save the changes to
       the address book */
      NSLog(@"Changes were found in the address book.");
      
      BOOL doYouWantToSaveChanges = YES;
      
      /* We can make a decision to save or revert the
       address book back to how it was before */
      if (doYouWantToSaveChanges == YES){
        
        CFErrorRef saveError = NULL;
        
        if (ABAddressBookSave(addressBook, &saveError) == YES){
          /* We successfully saved our changes to the
           address book */
        } else {
          /* We failed to save the changes. You can now
           access the [saveError] variable to find out
           what the error is */
        }
        
      } else {
        
        /* We did NOT want to save the changes to the address
         book so let's revert it to how it was before */
        ABAddressBookRevert(addressBook);
        
      } /* if (doYouWantToSaveChanges == YES){ */
      
    } else {
      /* We have not made any changes to the address book */
      NSLog(@"No changes to the address book.");
    }
    
    CFRelease(addressBook);
    
  } else {
    NSLog(@"Could not access the address book.");
  }
  
}


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
