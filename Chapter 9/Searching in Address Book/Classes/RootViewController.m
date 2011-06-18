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
            andSaveTo:(ABAddressBookRef)paramAddressBook{
  
  BOOL result = NO;
  
  if (paramPerson == nil ||
      paramGroup == nil ||
      paramAddressBook == nil){
    NSLog(@"Invalid parameters are given.");
    return(NO);
  }
  
  CFErrorRef Error = nil;
  
  /* Now attempt to add the person entry to the group */
  result = ABGroupAddMember(paramGroup,
                            paramPerson,
                            &Error);
  
  if (result == NO){
    NSLog(@"Could not add the person to the group.");
    return(NO);
  }
  
  /* Make sure we save any unsaved changes */
  if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
      ABAddressBookSave(paramAddressBook, &Error) == YES){
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
  couldSetFirstName = ABRecordSetValue(person,
                                       kABPersonFirstNameProperty, 
                                       paramFirstName,
                                       &Error);
  
  /* Set the last name of the person */
  couldSetLastName = ABRecordSetValue(person, 
                                      kABPersonLastNameProperty, 
                                      paramLastName, 
                                      &Error);
  
  if (couldSetFirstName == YES &&
      couldSetLastName == YES){
    NSLog(@"Successfully set the first and the last name of the person.");
    
    /* Add the person record to the address book. We have NOT saved yet */
    if (ABAddressBookAddRecord(paramAddressBook, person, &Error) == YES){
      NSLog(@"Successfully added the new person to the address book.");
      
      /* Now save the address book if there are any unsaved changes */
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &Error) == YES){
        
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
  
  couldSetGroupName = ABRecordSetValue(group, 
                                       kABGroupNameProperty, 
                                       paramGroupName,
                                       &error);
  
  if (couldSetGroupName == YES){
    
    if (ABAddressBookAddRecord(paramAddressBook, group, &error) == YES){
      NSLog(@"Successfully added the new group to the address book.");
      
      if (ABAddressBookHasUnsavedChanges(paramAddressBook) == YES &&
          ABAddressBookSave(paramAddressBook, &error) == YES){
        
        NSLog(@"Successfully saved the address book with the new group.");
        
        result = group;
        
      } else {
        /* Either no unsaved changes were there or we could not save the
         address book */
      }
      
    } else {
      NSLog(@"Could not add a new group to the address book.");
    }
    
  } else {
    NSLog(@"Failed to set the name of the group.");
  }
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL) doesPersonExistWithName:(NSString *)paramName 
         inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  BOOL result = NO;
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(NO);
  }
  
  CFArrayRef people = 
  ABAddressBookCopyPeopleWithName(paramAddressBook,
                                  (CFStringRef)paramName);
  
  if (people != nil){
    /* Is there at least one person in the array with the name
     we were looking for? */
    if (CFArrayGetCount(people) > 0){
      result = YES;
    }
  }
  
  people == nil ? /* Do Nothing */ : CFRelease(people);
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  doesPersonExistWithFirstName:(NSString *)paramFirstName 
          lastName:(NSString *)paramLastName
          inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  BOOL result = NO;
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(NO);
  }
  
  /* First we get all the people in the address book */
  CFArrayRef allPeople = 
  ABAddressBookCopyArrayOfAllPeople(paramAddressBook);
  
  /* Were we successful? */
  if (allPeople != nil){
    
    /* Go through all of them one by one */
    NSUInteger peopleCounter = 0;
    for (peopleCounter = 0;
         peopleCounter < CFArrayGetCount(allPeople);
         peopleCounter++){
      
      /* Get the current person as we are going to need this person's
       address book details (first name and last name) */
      ABRecordRef person = CFArrayGetValueAtIndex(allPeople, 
                                                  peopleCounter);
      
      /* Get the person's first name here */
      NSString *firstName = (NSString *)
      ABRecordCopyValue(person,
                        kABPersonFirstNameProperty);
      
      /* And then the last name */
      NSString *lastName = (NSString *)
      ABRecordCopyValue(person,
                        kABPersonLastNameProperty);
      
      /* This person has to pass a couple of checks
       before it can be identified as the person that we
       are looking for */
      BOOL firstNameIsEqual = NO;
      BOOL lastNameIsEqual = NO;
      
      /* ------------------- */
      
      /* Check the possible combinations of the current
       person's first name and the given first name parameter to
       detect if this person is the person we are looking for.
       Here we are checking the first name property */
      
      if (firstName == nil &&
          paramFirstName == nil){
        firstNameIsEqual = YES;
      }
      else if ([firstName isEqualToString:
                paramFirstName] == YES){
        firstNameIsEqual = YES;
      }
      
      /* ------------------- */
      
      /* And then check the last name property */
      if (lastName == nil &&
          paramLastName == nil){
        lastNameIsEqual = YES;
      }
      else if ([lastName isEqualToString:
                paramLastName] == YES){
        lastNameIsEqual = YES;
      }
      
      /* ------------------- */
      
      /* Release our resources. Note that we should
       NOT "break" before we have released these resources.
       This is a common programmming mistake */
      [firstName release];
      [lastName  release];
      
      if (firstNameIsEqual == YES &&
          lastNameIsEqual == YES){
        result = YES;
        break;
      }
      
    } /* for (peopleCounter = 0; ... */
    
  } /* if (allPeople != nil){ */
  
  allPeople == nil ? /* Do Nothing */ : CFRelease(allPeople);
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL) doesGroupExistWithGroupName:(NSString *)paramGroupName
         inAddressBook:(ABAddressBookRef)paramAddressBook{
  
  BOOL result = NO;
  
  if (paramAddressBook == nil){
    NSLog(@"The address book is nil.");
    return(NO);
  }
  
  /* First we get all the groups in the address book */
  CFArrayRef allGroups = 
  ABAddressBookCopyArrayOfAllGroups(paramAddressBook);
  
  /* Were we successful? */
  if (allGroups != nil){
    
    /* Go through all of them one by one */
    NSUInteger groupCounter = 0;
    for (groupCounter = 0;
         groupCounter < CFArrayGetCount(allGroups);
         groupCounter++){
      
      ABRecordRef group = 
      CFArrayGetValueAtIndex(allGroups, 
                             groupCounter);
      
      NSString *groupName = (NSString *)
      ABRecordCopyValue(group,
                        kABGroupNameProperty);
      
      BOOL groupNameIsEqual = NO;
      
      if (groupName == nil &&
          paramGroupName == nil){
        groupNameIsEqual = YES;
      }
      else if ([groupName isEqualToString:
                paramGroupName] == YES){
        groupNameIsEqual = YES;
      }
      
      [groupName release];
      
      if (groupNameIsEqual == YES){
        result = YES;
        break;
      }
      
    }
  } /* if (allGroups != nil){ */
  
  allGroups == nil ? /* Do Nothing */ : CFRelease(allGroups);
  
  return(result);
  
}

/* ------------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  ABAddressBookRef addressBook = ABAddressBookCreate();
//  
//  if (addressBook != nil){
//    NSLog(@"Successfully accessed the address book.");
//    
//    if ([self doesGroupExistWithGroupName:@"O'Reilly"
//                            inAddressBook:addressBook] == YES){
//      
//      NSLog(@"This group already exists.");
//      
//    } else {
//      
//      NSLog(@"This group does not exist.");
//      
//      ABRecordRef newGroup = 
//      [self createNewGroupWithName:@"O'Reilly"
//                     inAddressBook:addressBook];
//      
//      if (newGroup != nil){
//        NSLog(@"The new group is created successfully.");
//        CFRelease(newGroup);
//      } else {
//        NSLog(@"Failed to create the new group.");
//      }
//      
//    }
//    
//    CFRelease(addressBook);
//    
//  } /* if (addressBook != nil){ */
//  
//}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  if (addressBook != nil){
    NSLog(@"Successfully accessed the address book.");
    
    if ([self doesPersonExistWithName:@"leonardo d"
                        inAddressBook:addressBook] == YES){
      
      NSLog(@"This person already exists.");
      
    } else {
      NSLog(@"This person does not exist. Creating...");
      
      ABRecordRef newPerson = 
      [self createNewPersonWithFirstName:@"Leonardo"
                                lastName:@"DiCaprio"
                           inAddressBook:addressBook];
      
      if (newPerson != nil){
        NSLog(@"The new person object is created successfully.");
        CFRelease(newPerson);
      } else {
        NSLog(@"Failed to create the new person object.");
      }
      
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
