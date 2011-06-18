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
  
  /* If we could not find a CalDAV calendar that 
   we were looking for, then we will abort the operation */
  if (targetCalendar == nil){
    NSLog(@"No CalDAV calendars were found.");
    return;
  }
  
  /* We have to pass an array of calendars
   to the event store to search */
  NSArray *targetCalendars = 
  [NSArray arrayWithObject:targetCalendar];
  
  /* Instantiate the event store */
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  /* We use the Calendar object to 
   construct a starting and ending date */
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
  
  /* Create the predicate that we can later pass to 
   the event store in order to fetch the events */
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
  
  /* Fetch all the events that fall between the
   starting and the ending dates */
  NSArray *events = 
  [eventStore eventsMatchingPredicate:searchPredicate];
  
  /* Array of NSString equivalents of the values
   in the EKParticipantRole enumeration */
  NSArray *attendeeRole = [NSArray arrayWithObjects:
                           @"Unknown",
                           @"Required",
                           @"Optional",
                           @"Chair",
                           @"Non Participant",
                           nil];
  
  /* Array of NSString equivalents of the values
   in the EKParticipantStatus enumeration */
  NSArray *attendeeStatus = [NSArray arrayWithObjects:
                             @"Unknown",
                             @"Pending",
                             @"Accepted",
                             @"Declined",
                             @"Tentative",
                             @"Delegated",
                             @"Completed",
                             @"In Process",
                             nil];
  /* Array of NSString equivalents of the values
   in the EKParticipantType enumeration */
  NSArray *attendeeType = [NSArray arrayWithObjects:
                           @"Unknown",
                           @"Person",
                           @"Room",
                           @"Resource",
                           @"Group",
                           nil];
  
  /* Go through all the events and print their information
   out to the console */
  if (events != nil){
    
    NSUInteger eventCounter = 0;
    for (EKEvent *thisEvent in events){
      
      eventCounter++;
      
      NSLog(@"Event %lu Start Date = %@", 
            (unsigned long)eventCounter, 
            thisEvent.startDate);
      
      NSLog(@"Event %lu End Date = %@", 
            (unsigned long)eventCounter, 
            thisEvent.endDate);
      
      NSLog(@"Event %lu Title = %@", 
            (unsigned long)eventCounter, 
            thisEvent.title);
      
      if (thisEvent.attendees == nil ||
          [thisEvent.attendees count] == 0){
        NSLog(@"Event %lu has no attendees", 
              (unsigned long)eventCounter);
        continue;
      }
      
      NSUInteger attendeeCounter = 1;
      for (EKParticipant *participant in thisEvent.attendees){
        
        NSLog(@"Event %lu Attendee %lu Name = %@",
              (unsigned long)eventCounter, 
              (unsigned long)attendeeCounter,
              participant.name);
        
        NSLog(@"Event %lu Attendee %lu Role = %@",
              (unsigned long)eventCounter, 
              (unsigned long)attendeeCounter,
              [attendeeRole objectAtIndex:
               participant.participantRole]);
        
        NSLog(@"Event %lu Attendee %lu Status = %@",
              (unsigned long)eventCounter,
              (unsigned long)attendeeCounter,
              [attendeeStatus objectAtIndex:
               participant.participantStatus]);
        
        NSLog(@"Event %lu Attendee %lu Type = %@",
              (unsigned long)eventCounter, 
              (unsigned long)attendeeCounter,
              [attendeeType objectAtIndex:
               participant.participantType]);
        
        NSLog(@"Event %lu Attendee %lu URL = %@",
              (unsigned long)eventCounter, 
              (unsigned long)attendeeCounter,
              participant.URL);
        
        attendeeCounter++;
        
      }
      
    } /* for (EKEvent *Event in Events){ */
    
  } else {
    NSLog(@"The array of events is nil.");
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
