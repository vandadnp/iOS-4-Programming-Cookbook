//
//  RootViewController_iPhone.m
//  Test
//
//  Created by Vandad Nahavandipoor on 10-07-28.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController_iPhone.h"

@implementation RootViewController_iPhone

/* ----------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  /* These are the calendar types an iOS Device can have. Please note
   that the "type" property of an object of type EKCalendar
   is of type EKCalendarType. The values in the "CalendarTypes"
   array reflect the exact same values in the EKCalendarType
   enumeration, but as NSString values */
  NSArray *calendarTypes = [NSArray arrayWithObjects:
                            @"Local",
                            @"CalDAV",
                            @"Exchange",
                            @"Subscription",
                            @"Birthday",
                            nil];
  
  /* Go through the calendars one by one */
  NSUInteger counter = 1;
  for (EKCalendar *thisCalendar in eventStore.calendars){
    
    /* The title of the calendar */
    NSLog(@"Calendar %lu Title = %@", 
          (unsigned long)counter, thisCalendar.title);
    
    /* The type of the calendar */
    NSLog(@"Calendar %lu Type = %@", 
          (unsigned long)counter, 
          [calendarTypes objectAtIndex:thisCalendar.type]);
    
    /* The color that is associated with the calendar */
    NSLog(@"Calendar %lu Color = %@", 
          (unsigned long)counter, 
          [UIColor colorWithCGColor:thisCalendar.CGColor]);
    
    /* And weather the calendar can be modified or not */
    if (thisCalendar.allowsContentModifications == YES){
      NSLog(@"Calendar %lu can be modified.", 
            (unsigned long)counter);
    } else {
      NSLog(@"Calendar %lu cannot be modified.", 
            (unsigned long)counter);
    }
    
    counter++;
  }
  
  [eventStore release];
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ----------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

/* ----------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ----------------------------------- */

@end
