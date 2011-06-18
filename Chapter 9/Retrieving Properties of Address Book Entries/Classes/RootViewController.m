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

- (void) logContactEmailAddresses:(ABRecordRef)paramContact{
  
  if (paramContact == nil){
    return;
  }
  
  ABMultiValueRef emails = ABRecordCopyValue(paramContact,
                                             kABPersonEmailProperty);
  
  /* This contact does not have an email property */
  if (emails == nil){
    return;
  }
  
  /* Go through all the emails */
  NSUInteger emailCounter = 0;
  for (emailCounter = 0;
       emailCounter < ABMultiValueGetCount(emails);
       emailCounter++){
    
    /* Get the label of the email (if any) */
    NSString *emailLabel = (NSString *)
    ABMultiValueCopyLabelAtIndex(emails, emailCounter);
    
    NSString *localizedEmailLabel = (NSString *)
    ABAddressBookCopyLocalizedLabel((CFStringRef)emailLabel);
    
    /* And then get the email address itself */
    NSString *email = (NSString *)
    ABMultiValueCopyValueAtIndex(emails, emailCounter);
    
    NSLog(@"Label = %@, Localized Label = %@, Email = %@", 
          emailLabel, localizedEmailLabel, email);
    
    [email release];
    [localizedEmailLabel release];
    [emailLabel release];
  }
  
  CFRelease(emails);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    CFArrayRef allPeople = 
    ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    if (allPeople != nil){
      
      NSUInteger peopleCounter = 0;
      for (peopleCounter = 0;
           peopleCounter < CFArrayGetCount(allPeople);
           peopleCounter++){
        
        ABRecordRef thisPerson = 
        CFArrayGetValueAtIndex(allPeople, 
                               peopleCounter);
        
        NSString *firstName = 
        (NSString *)ABRecordCopyValue(thisPerson, 
                                      kABPersonFirstNameProperty);
        
        NSString *lastName = (NSString *)
        ABRecordCopyValue(thisPerson, 
                          kABPersonLastNameProperty);
        
        NSString *address = (NSString *)
        ABRecordCopyValue(thisPerson,
                          kABPersonEmailProperty);
        
        [self logContactEmailAddresses:thisPerson];
        
        NSLog(@"First Name = %@", firstName);
        NSLog(@"Last Name = %@", lastName);
        NSLog(@"Address = %@", address);
        
        [firstName release];
        [lastName release];
        [address release];
        
        /* Use the [thisPerson] address book record */
        
      } /* for (peopleCounter = 0; ... */
      
      CFRelease(allPeople);
    } /* if (allPeople != nil){ */
    
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
