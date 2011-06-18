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

- (BOOL)    createEventWithTitle:(NSString *)paramTitle
                       startDate:(NSDate *)paramStartDate 
                         endDate:(NSDate *)paramEndDate 
             inCalendarWithTitle:(NSString *)paramCalendarTitle
              inCalendarWithType:(EKCalendarType)paramCalendarType 
                       withNotes:(NSString *)paramNotes{
  
  BOOL result = NO;
  
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  /* Are there any calendars available to the event store? */
  if (eventStore.calendars == nil ||
      [eventStore.calendars count] == 0){
    [eventStore release];
    eventStore = nil;
    NSLog(@"No calendars are found.");
    return(NO);
  }
  
  EKCalendar *targetCalendar = nil;
  
  /* Try to find the calendar that the user asked for */
  for (EKCalendar *thisCalendar in eventStore.calendars){
    if ([thisCalendar.title 
         isEqualToString:paramCalendarTitle] == YES &&
        thisCalendar.type == paramCalendarType){
      targetCalendar = thisCalendar;
      break;
    }
  }
  
  /* Make sure we found the calendar that we were asked to find */
  if (targetCalendar == nil){
    NSLog(@"Could not find the requested calendar.");
    [eventStore release];
    return(NO);
  }
  
  /* If a calendar does not allow modification of its contents
   then we can not insert an event into it */
  if (targetCalendar.allowsContentModifications == NO){
    NSLog(@"The selected calendar does not allow modifications.");
    [eventStore release];
    return(NO);
  }
  
  /* Create an event */
  EKEvent *event = [EKEvent eventWithEventStore:eventStore];
  event.calendar = targetCalendar;
  
  /* Set the properties of the event such as its title,
   start date/time, end date/time and etc */
  event.title = paramTitle;
  event.notes = paramNotes;
  event.startDate = paramStartDate;
  event.endDate = paramEndDate;
  
  /* Finally, save the event into the calendar */
  NSError *saveError = nil;
  
  result = [eventStore saveEvent:event
                            span:EKSpanThisEvent
                           error:&saveError];
  
  if (result == NO){
    NSLog(@"An error occurred = %@", saveError);
  }
  
  [eventStore release];
  
  return(result);
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* The event starts from today, right now */
  NSDate *startDate = [NSDate date];
  
  /* And the event ends this time tomorrow.
   24 hours, 60 minutes per hour and 60 seconds per minute 
   hence 24 * 60 * 60 */
  NSDate *endDate = [startDate 
                     dateByAddingTimeInterval:24 * 60 * 60];
  
  /* Create the new event */
  [self createEventWithTitle:@"My event"
                   startDate:startDate
                     endDate:endDate
         inCalendarWithTitle:@"Calendar"
          inCalendarWithType:EKCalendarTypeLocal
                   withNotes:nil];
  
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
