//
//  RootViewController_iPhone.m
//  Test
//
//  Created by Vandad Nahavandipoor on 10-07-28.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController_iPhone.h"

/* ----------------------------------- */

@implementation RootViewController_iPhone

/* ----------------------------------- */

@synthesize eventStore;

/* ----------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
  }
  
  return(self);
  
}

/* ----------------------------------- */

//- (void) pushController:(UIViewController *)paramController{
//  
//  [self.navigationController 
//   pushViewController:paramController
//   animated:YES];
//  
//}

/* ----------------------------------- */

- (void) pushController:(UIViewController *)paramController{
  
  UIBarButtonItem *backButton = 
  [[UIBarButtonItem alloc] 
   initWithTitle:NSLocalizedString(@"Go Back", nil)
   style:UIBarButtonItemStylePlain
   target:nil
   action:nil];
  
  self.navigationItem.backBarButtonItem = backButton;
  
  [backButton release];
  
  [self.navigationController 
   pushViewController:paramController
   animated:YES];
  
}

/* ----------------------------------- */

- (void) displayLastEvent{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSDate *startDate = 
  [NSDate 
   dateWithTimeIntervalSinceNow:-(365 * 24 * 60 * 60)];
  
  NSDate *endDate = [NSDate date];
  
  NSPredicate *predicate = 
  [self.eventStore 
   predicateForEventsWithStartDate:startDate
   endDate:endDate
   calendars:self.eventStore.calendars];
  
  NSArray *events = 
  [self.eventStore eventsMatchingPredicate:predicate];
  
  if (events == nil ||
      [events count] == 0){
    NSLog(@"No events were found.");
  } else {
    
    /* Get the newest events at the end of the array */
    SEL sortingSelector = @selector(compareStartDateWithEvent:);
    events = 
    [events 
     sortedArrayUsingSelector:sortingSelector];
        
    /* And pick the last event (The newest) */
    EKEvent *event = [events lastObject];
    
    /* Construct the event view controller */
    EKEventViewController *controller = 
    [[EKEventViewController alloc] init];
    
    /* Make sure to set the event that has to be viewed */
    controller.event = event;
    
    /* Do not allow the user to edit this event */
    controller.allowsEditing = NO;
    controller.allowsCalendarPreview = YES;
    
    /* And make sure pushing the view controller happens on the 
     main UI thread */
    [self performSelectorOnMainThread:@selector(pushController:)
                           withObject:controller
                        waitUntilDone:NO];
    
    [controller release];
    
  }
  
  [pool release];
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];

  EKEventStore *newEventStore = 
  [[EKEventStore alloc] init];
  
  self.eventStore = newEventStore;
  [newEventStore release];
  
  [self 
   performSelectorInBackground:@selector(displayLastEvent)
   withObject:nil];
  
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  self.eventStore = nil;
  
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
}

/* ----------------------------------- */

- (void)dealloc {
  [eventStore release];
  [super dealloc];
}

/* ----------------------------------- */

@end