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

- (EKCalendar *)  getFirstAvailableCalDAVCalendar{
  
  EKCalendar *result = nil;
  
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  for (EKCalendar *thisCalendar in eventStore.calendars){
    
    if (thisCalendar.type == EKCalendarTypeCalDAV){
      [eventStore release];
      return(thisCalendar);
    }
    
  }
  
  [eventStore release];
  
  return(result);
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Find a calendar to base our search on */
  EKCalendar *targetCalendar = 
  [self getFirstAvailableCalDAVCalendar];
  
  /* If we could not find a CalDAV calendar that we were looking for,
   then we will abort the operation */
  if (targetCalendar == nil){
    NSLog(@"No CalDAV calendars were found.");
    return;
  }
  
  /* We have to pass an array of calendars to the event store to search */
  NSArray *targetCalendars = 
  [NSArray arrayWithObject:targetCalendar];
  
  /* Instantiate the event store */
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  
  /* We use the Calendar object to construct 
   a starting and ending date */
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  /* Using the components in this object 
   we can construct a starting date */
  NSDateComponents *startDateComponents = 
  [[NSDateComponents alloc] init];
  
  /* The start date will be 31st of July 2010 at 00:00:00 */
  [startDateComponents setHour:0];
  [startDateComponents setMinute:0];
  [startDateComponents setSecond:0];
  [startDateComponents setYear:2010];
  [startDateComponents setMonth:7];
  [startDateComponents setDay:31];
  
  /* Construct the starting date using the components */
  NSDate *startDate =
  [calendar dateFromComponents:startDateComponents];
  
  /* The end date will be 1st of August 2010 at 00:00:00. 
   Exactly 24 hours after the starting date */
  NSDate *endDate = 
  [startDate dateByAddingTimeInterval:24 * 60 * 60];
  
  /* We do not need these components anymore */
  [startDateComponents release];
  
  /* Create the predicate that we can later pass to the 
   event store in order to fetch the events */
  NSPredicate *searchPredicate = 
  [eventStore predicateForEventsWithStartDate:startDate
                                      endDate:endDate
                                    calendars:targetCalendars];
  
  /* Make sure we succeeded in creating the predicate */
  if (searchPredicate == nil){
    NSLog(@"Could not create the search predicate.");
    [eventStore release];
    return;
  }
  
  /* Fetch all the events that fall between
   the starting and the ending dates */
  NSArray *events = 
  [eventStore eventsMatchingPredicate:searchPredicate];
  
  /* Go through all the events and print their information
   out to the console */
  if (events != nil){
    
    NSUInteger counter = 1;
    for (EKEvent *event in events){
      
      NSLog(@"Event %lu Start Date = %@", 
            (unsigned long)counter,
            event.startDate);
      
      NSLog(@"Event %lu End Date = %@", 
            (unsigned long)counter, 
            event.endDate);
      
      NSLog(@"Event %lu Title = %@", 
            (unsigned long)counter, 
            event.title);
      
      counter++;
    }
    
  } else {
    NSLog(@"The array of events for this start/end time is nil.");
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
  [super didReceiveMemoryWarning];
}

/* ----------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ----------------------------------- */

@end
