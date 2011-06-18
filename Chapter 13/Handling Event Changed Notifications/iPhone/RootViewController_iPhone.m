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

@synthesize tableViewEvents;
@synthesize arrayOfEvents;
@synthesize eventStore;
@synthesize editButton;
@synthesize doneButton;

/* ----------------------------------- */

- (void)        tableView:(UITableView *)tableView 
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  /* Make sure this is a deletion operation on the events table
   view that we have */
  
  if ([tableView isEqual:self.tableViewEvents] == YES &&
      editingStyle == UITableViewCellEditingStyleDelete){
    
    /* We have the index path of the row so now
     let's get the corresponding event from the array of
     events that we have */
    EKEvent *event = [self.arrayOfEvents objectAtIndex:indexPath.row];
    
    NSError *removeError = nil;
    
    /* Attempt to remove the event from the store */
    if ([self.eventStore removeEvent:event
                                span:EKSpanThisEvent
                               error:&removeError] == YES){
      
      [self.arrayOfEvents removeObject:event];
      
      NSArray *rowsToDelete = [NSArray arrayWithObject:indexPath];
      
      /* Delete the row for the current event with a nice animation */
      [tableView deleteRowsAtIndexPaths:rowsToDelete
                       withRowAnimation:UITableViewRowAnimationFade];
      
    } else {
      NSLog(@"Failed to remove the event %@", removeError);
    }
    
  }
  
}

/* ----------------------------------- */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

  UITableViewCellEditingStyle result = 
  UITableViewCellEditingStyleNone;
  
  if ([tableView isEqual:self.tableViewEvents] == YES){
    /* We only want the user to be able to delete evenets, not
     any other editing style */
    result = UITableViewCellEditingStyleDelete;
  }
  
  return(result);
  
}

/* ----------------------------------- */

- (NSInteger)tableView:(UITableView *)table
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.tableViewEvents] == YES){
    
    if (self.arrayOfEvents != nil){
      /* We only have one section and in this one section
       the number of rows is exactly equal to the 
       number of events that we have in our array */
      result = [self.arrayOfEvents count];
    }
    
  }
  
  return(result);
  
}

/* ----------------------------------- */

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *result = nil;
  
  if ([tableView isEqual:self.tableViewEvents] == YES){
    
    static NSString *EventsCellIdentifier = @"Events";
    
    /* We have the index path so let's get the corresponding
     event from the array of events */
    EKEvent *Event = 
    [self.arrayOfEvents objectAtIndex:indexPath.row];
    
    /* Try to get a reusable table cell */
    result = 
    [tableView 
     dequeueReusableCellWithIdentifier:EventsCellIdentifier];
    
    if (result == nil){
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:EventsCellIdentifier] autorelease];
    }
    
    /* The title text of the cell will be the title of the event */
    result.textLabel.text = Event.title;
    result.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    result.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    /* Now let's format the date and the time of the event
     and display it as the subtitle of the cell */
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = 
    [calendar components:
     NSYearCalendarUnit | 
     NSMonthCalendarUnit | 
     NSDayCalendarUnit |
     NSHourCalendarUnit |
     NSMinuteCalendarUnit |
     NSSecondCalendarUnit
                fromDate:Event.startDate];
    
    if ([components hour] == 0 &&
        [components minute] == 0 &&
        [components second] == 0){
      
      result.detailTextLabel.text = 
      [NSString stringWithFormat:
       @"Starts on %02ld/%02ld/%02ld All Day",
       (long)[components year],
       (long)[components month],
       (long)[components day]];
      
    } else {
      result.detailTextLabel.text = 
      [NSString stringWithFormat:
       @"Starts on %02ld/%02ld/%02ld at %ld:%ld:%ld", 
       (long)[components year],
       (long)[components month],
       (long)[components day],
       (long)[components hour],
       (long)[components minute],
       (long)[components second]];
    }
    
  }
  
  return(result);
  
}

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

- (void)          alertView:(UIAlertView *)alertView 
  didDismissWithButtonIndex:(NSInteger)buttonIndex{
  
  if (alertView.tag == REFRESH_ARRAY_ALERTVIEW_ID){
    [self.arrayOfEvents removeAllObjects];
    [self.tableViewEvents reloadData];
  }
  
  SEL selectorToCall = 
  @selector(fetchAllEventsSinceLastYearUntilNow);
  
  [self 
   performSelectorInBackground:selectorToCall
   withObject:nil];
  
}

/* ----------------------------------- */

- (void) fetchAllEventsSinceLastYearUntilNow{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
  /* Instantiate the event store */
  EKEventStore *newEventStore = [[EKEventStore alloc] init];
  self.eventStore = newEventStore;
  [newEventStore release];
  
  NSMutableArray *targetCalendars = [[NSMutableArray alloc] init];
  
  for (EKCalendar *thisCalendar in self.eventStore.calendars){
    if (thisCalendar.allowsContentModifications == YES){
      [targetCalendars addObject:thisCalendar];
    }
  }
  
  /* Start from a year ago (StartDate) and end on today's date */
  
  NSDate *endDate = [NSDate date];
  
  
  NSDate *startDate = 
  [endDate 
   dateByAddingTimeInterval:-(1 * 365 * 24 * 60 * 60)];
  
  /* Create the predicate that we can later pass 
   to the event store in order to fetch the events */
  NSPredicate *searchPredicate = 
  [self.eventStore predicateForEventsWithStartDate:startDate
                                           endDate:endDate
                                         calendars:targetCalendars];
  
  [targetCalendars release];
  
  /* Make sure we succeeded in creating the predicate */
  if (searchPredicate == nil){
    NSLog(@"Could not create the search predicate.");
    return;
  }
  
  /* Fetch all the events that fall between the 
   starting and the ending dates */
  NSArray *allEvents = 
  [self.eventStore eventsMatchingPredicate:searchPredicate];
  
  if (allEvents != nil){
    SEL sortingSelector = @selector(compareStartDateWithEvent:);
    /* Sort our events by their start date */
    allEvents = 
    [allEvents 
     sortedArrayUsingSelector:sortingSelector];
    
    self.arrayOfEvents = 
    [NSMutableArray arrayWithArray:allEvents];
  }
  
  /* We are on a separate thread now. Make sure that we call
   the reloadData method of the table view on the main thread */
  if (self.arrayOfEvents != nil){
    [self.tableViewEvents 
     performSelectorOnMainThread:@selector(reloadData)
     withObject:nil
     waitUntilDone:NO];
  }
  
  [pool release];
  
}

/* ----------------------------------- */

- (void) handleEventStoreChanged:(NSNotification *)paramNotification{
  
  NSLog(@"The calendar database has been changed.");
  
  NSLog(@"Object = %@", [paramNotification object]);
  
  if (self.tableViewEvents.editing == YES){
    [self finishEditing:nil];
  }
  
  NSString *alertTitle = 
  NSLocalizedString(@"Calendar Database Has Been Changed", nil);
  
  NSString *alertMessage = 
  NSLocalizedString(@"Please Press OK To Refresh", nil);
  
  UIAlertView *alertView = 
  [[[UIAlertView alloc] 
    initWithTitle:alertTitle
    message:alertMessage
    delegate:self
    cancelButtonTitle:NSLocalizedString(@"OK", nil)
    otherButtonTitles:nil, nil] autorelease];
  
  alertView.tag = REFRESH_ARRAY_ALERTVIEW_ID;
  
  [alertView show];
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *newEditButton = 
  [[UIBarButtonItem alloc]
   initWithTitle:NSLocalizedString(@"Edit", nil)
   style:UIBarButtonItemStylePlain
   target:self
   action:@selector(startEditing:)];
  self.editButton = newEditButton;
  [newEditButton release];
  
  UIBarButtonItem *newDoneButton =
  [[UIBarButtonItem alloc]
   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
   target:self
   action:@selector(finishEditing:)];
  self.doneButton = newDoneButton;
  [newDoneButton release];
  
  [[NSNotificationCenter defaultCenter] 
   addObserver:self
   selector:@selector(handleEventStoreChanged:)
   name:EKEventStoreChangedNotification
   object:nil];
  
  [self displayNormalNavigationItems];
  
  self.title = NSLocalizedString(@"Events", nil);
  
  SEL selectorToCall = 
  @selector(fetchAllEventsSinceLastYearUntilNow);
  
  [self 
   performSelectorInBackground:selectorToCall
   withObject:nil];
  
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [[NSNotificationCenter defaultCenter] 
   removeObserver:self
   name:EKEventStoreChangedNotification
   object:nil];
  
  self.tableViewEvents = nil;
  self.arrayOfEvents = nil;
  self.eventStore = nil;
  self.editButton = nil;
  self.doneButton = nil;
  
  self.navigationItem.rightBarButtonItem = nil;
  self.navigationItem.leftBarButtonItem = nil;
  
}

/* ----------------------------------- */

- (void) startEditing:(id)paramSender{
  
  if (self.tableViewEvents.editing == NO){
    
    /* Take the table view into editing mode */
    [self.tableViewEvents setEditing:YES
                            animated:YES];
    
    [self displayEditingNavigationItems];
    
  }
  
}

/* ----------------------------------- */

- (void) finishEditing:(id)paramSender{
  
  if (self.tableViewEvents.editing == YES){
    /* Take the table view out of the editing mode */
    [self.tableViewEvents setEditing:NO
                            animated:YES];
    
    [self displayNormalNavigationItems];
  }
  
}

/* ----------------------------------- */

- (void) displayNormalNavigationItems{
  
  /* Only display the edit button on the top left */
  
  [self.navigationItem setLeftBarButtonItem:self.editButton
                                   animated:YES];
  
  /* And nothing for the right navigation bar button */
  [self.navigationItem setRightBarButtonItem:nil
                                    animated:YES];
  
}

/* ----------------------------------- */

- (void) displayEditingNavigationItems{
  
  /* Nothing for the left button */
  [self.navigationItem setLeftBarButtonItem:nil
                                   animated:YES];
  
  [self.navigationItem 
   setRightBarButtonItem:self.doneButton
   animated:YES];
  
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all interface orientations */
  return (YES);
}

/* ----------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ----------------------------------- */

- (void)dealloc {
  [tableViewEvents release];
  [arrayOfEvents release];
  [eventStore release];  
  [editButton release];
  [doneButton release];
  [super dealloc];
}

/* ----------------------------------- */

@end
