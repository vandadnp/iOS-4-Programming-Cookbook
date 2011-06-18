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

- (EKCalendar *)  getFirstModifiableLocalCalendar{
  
  EKCalendar *result = nil;
  
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  for (EKCalendar *thisCalendar in eventStore.calendars){
    if (thisCalendar.type == EKCalendarTypeLocal &&
        thisCalendar.allowsContentModifications == YES){
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
  
  EKCalendar *targetCalendar = 
  [self getFirstModifiableLocalCalendar];
  
  if (targetCalendar == nil){
    NSLog(@"Could not find the target calendar.");
    return;
  }
  
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  
  /* The event starts 60 seconds from now */
  NSDate *startDate = 
  [NSDate dateWithTimeIntervalSinceNow:60.0f];
  
  /* And end the event 20 seconds after its start date */
  NSDate *endDate = 
  [startDate dateByAddingTimeInterval:20.0f];
  
  EKEvent *eventWithAlarm = 
  [EKEvent eventWithEventStore:eventStore];
  
  eventWithAlarm.calendar = targetCalendar;
  eventWithAlarm.startDate = startDate;
  eventWithAlarm.endDate = endDate;
  
  /* The alarm goes off 2 seconds before the event happens */
  EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-2.0f];
  
  eventWithAlarm.title = @"Event with Alarm";
  [eventWithAlarm addAlarm:alarm];
  
  NSError *saveError = nil;
  
  if ([eventStore saveEvent:eventWithAlarm
                       span:EKSpanThisEvent
                      error:&saveError] == YES){
    NSLog(@"Saved an event that fires 60 seconds from now.");
  } else {
    NSLog(@"Failed to save the event. Error = %@", saveError);
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
