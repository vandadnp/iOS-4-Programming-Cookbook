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
    
    CFArrayRef arrayOfAllPeople = 
    ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    if (arrayOfAllPeople != nil){
      
      NSUInteger peopleCounter = 0;
      for (peopleCounter = 0;
           peopleCounter < CFArrayGetCount(arrayOfAllPeople);
           peopleCounter++){
        
        ABRecordRef thisPerson = 
        CFArrayGetValueAtIndex(arrayOfAllPeople, 
                               peopleCounter);
        
        NSLog(@"%@", thisPerson);
        
        /* Use the [thisPerson] address book record */
        
      }
      
      CFRelease(arrayOfAllPeople);
    } /* if (allPeople != nil){ */
    
    CFRelease(addressBook);
    
  } /* if (addressBook != nil){ */

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
