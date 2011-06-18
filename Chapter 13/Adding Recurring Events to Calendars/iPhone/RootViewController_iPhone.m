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
  
  /* Step 1: And now the event store */
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  /* Step 2: Find the first local calendar that is modifiable */
  EKCalendar *targetCalendar = nil;
  
  for (EKCalendar *thisCalendar in eventStore.calendars){
    if (thisCalendar.type == EKCalendarTypeLocal &&
        thisCalendar.allowsContentModifications == YES){
      targetCalendar = thisCalendar;
    }
  }
  
  /* The target calendar wasn't found? */
  if (targetCalendar == nil){
    NSLog(@"The target calendar is nil.");
    [eventStore release];
    return;
  }
  
  /* Step 3: Create an event */
  EKEvent *event = [EKEvent eventWithEventStore:eventStore];
  
  /* Step 4: Create and event that happens today and happens
   every month for a year from now */
  
  NSDate *eventStartDate = [NSDate date];
  
  /* Step 5: The event's end date is one hour 
   from the moment it is created */
  NSDate *eventEndDate = 
  [eventStartDate dateByAddingTimeInterval:1 * 60 * 60];  
  
  /* Assign the required properties, especially 
   the target calendar */
  event.calendar = targetCalendar;
  event.title = @"My Event";
  event.startDate = eventStartDate;
  event.endDate = eventEndDate;
    
  /* The end date of the recurring rule 
   is one year from now */
  NSDate *oneYearFromNow = 
  [[NSDate date] 
   dateByAddingTimeInterval:365 * 24 * 60 * 60];
  
  /* Step 6: Create an Event Kit date from this date */
  EKRecurrenceEnd *recurringEnd = 
  [EKRecurrenceEnd recurrenceEndWithEndDate:oneYearFromNow];
  
  /* Step 7: And the recurring rule. This event happens every
   month (EKRecurrenceFrequencyMonthly), once a month (interval:1)
   and the recurring rule ends a year from now (end:RecurringEnd) */
  
  EKRecurrenceRule *recurringRule = 
  [[EKRecurrenceRule alloc] 
   initRecurrenceWithFrequency:EKRecurrenceFrequencyMonthly
   interval:1
   end:recurringEnd];
  
  /* Step 8: Set the recurring rule for the event */
  event.recurrenceRule = recurringRule;
  
  [recurringRule release];
  
  NSError *saveError = nil;
  
  /* Step 9: Save the event */
  if ([eventStore saveEvent:event
                       span:EKSpanFutureEvents
                      error:&saveError] == YES){
    NSLog(@"Successfully created the recurring event.");
  } else {
    NSLog(@"Failed to create the recurring event %@", saveError);
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
