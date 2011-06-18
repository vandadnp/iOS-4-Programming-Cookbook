//
//  RootViewController.m
//  Contacts
//
//  Created by Vandad Nahavandipoor on 10-07-20.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

/* ------------------------------- */

@synthesize imageViewOldImage, imageViewNewImage;

/* ------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
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
  CFErrorRef error = nil;
  
  /* Set the first name of the person */
  couldSetFirstName = ABRecordSetValue(person,
                                       kABPersonFirstNameProperty, 
                                       paramFirstName,
                                       &error);
  
  /* Set the last name of the person */
  couldSetLastName = ABRecordSetValue(person, 
                                      kABPersonLastNameProperty, 
                                      paramLastName, 
                                      &error);
  
  if (couldSetFirstName == YES &&
      couldSetLastName == YES){
    NSLog(@"Successfully set the first and the last name of the person.");
    
    /* Add the person record to the address book. We have NOT saved yet */
    if (ABAddressBookAddRecord(paramAddressBook, person, &error) == YES){
      NSLog(@"Successfully added the new person to the address book.");
      
      /* Now save the address book if there are any unsaved changes */
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &error) == YES){
        
        NSLog(@"Successfully saved the address book with the new person.");
        
        result = person;
        
      } else {
        /* Either no unsaved changes were there or we could not save the
         address book */
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

- (ABRecordRef) copyFirstPersonWithName:(NSString *)paramName 
                          inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  ABRecordRef result = nil;
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(NO);
  }
  
  CFArrayRef people = ABAddressBookCopyPeopleWithName(paramAddressBook,
                                                      (CFStringRef)paramName);
  
  if (people != nil){
    /* Is there at least one person in the array with the name
     we were looking for? */
    if (CFArrayGetCount(people) > 0){
      /* Get the first person with this name */
      result = CFRetain(CFArrayGetValueAtIndex(people, 0));
      
    }
  }
  
  people == nil ? /* Do Nothing */ : CFRelease(people);
  
  return(result);
  
}

/* ------------------------------- */

- (UIImage *) getPersonImage:(ABRecordRef)paramPerson{
  
  UIImage *result = nil;
  
  if (paramPerson == nil){
    NSLog(@"The person is nil.");
    return(nil);
  }
  
  NSData *imageData = (NSData *)ABPersonCopyImageData(paramPerson);
  if (imageData != nil){
    UIImage *image = [UIImage imageWithData:imageData];
    result = image;
  }
  
  [imageData release];
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL) setPersonImage:(ABRecordRef)paramPerson
          inAddressBook:(ABAddressBookRef)paramAddressBook 
          withImageData:(NSData *)paramImageData{
  
  BOOL result = NO;
  
  if (paramPerson == nil){
    NSLog(@"The person is nil.");
    return(NO);
  }
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(NO);
  }
  
  CFErrorRef error = nil;
  
  if (ABPersonSetImageData(paramPerson,
                           (CFDataRef)paramImageData, 
                           &error) == YES){
    
    NSLog(@"Successfully set the person's image. Saving...");
    
    if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
        ABAddressBookSave(paramAddressBook, &error) == YES){
      NSLog(@"Successfully saved the changes.");
      result = YES;
    } else {
      NSLog(@"Failed to save the changes.");
    }
    
  } else {
    NSLog(@"Could not set the image data.");
  }
  
  return(result);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    ABRecordRef person = nil;
    
    person = 
    [self copyFirstPersonWithName:@"Leonardo DiCaprio"
                    inAddressBook:addressBook];
    
    if (person != nil){
      NSLog(@"This person already exists in the address book.");
    } else {
      NSLog(@"This person doesn't exist. Creating...");
      person = 
      [self createNewPersonWithFirstName:@"Leonardo" 
                                lastName:@"DiCaprio"
                           inAddressBook:addressBook];
    }
    
    if (person != nil){
      
      UIImage *oldImage = [self getPersonImage:person];
      self.imageViewOldImage.image = oldImage;
      
      UIImage *newImage = 
      [UIImage imageNamed:@"LeonardoDiCaprio.png"];
      
      NSData  *newImageData = 
      UIImagePNGRepresentation(newImage);
      
      if ([self setPersonImage:person
                 inAddressBook:addressBook
                 withImageData:newImageData] == YES){
        NSLog(@"Successfully set the new image.");
        self.imageViewNewImage.image = newImage;
      } else {
        NSLog(@"Failed to set the new image.");
      }
      
      CFRelease(person);
      
    } else {
      NSLog(@"The person cannot be found.");
    }
    
    
    CFRelease(addressBook);
    
  } /* if (addressBook != nil){ */
  
}

/* ------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.imageViewNewImage = nil;
  self.imageViewOldImage = nil;
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



- (void)dealloc {
  [imageViewNewImage release];
  [imageViewOldImage release];
  [super dealloc];
}


@end
