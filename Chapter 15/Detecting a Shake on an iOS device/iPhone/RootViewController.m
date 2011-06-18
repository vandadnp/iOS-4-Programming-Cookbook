//
//  RootViewController.m
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ----------------------------------- */

@implementation RootViewController

/* ----------------------------------- */

@synthesize tableViewShakes;
@synthesize arrayOfShakeDateAndTimes;

/* ----------------------------------- */

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.tableViewShakes] == YES){
    result = [self.arrayOfShakeDateAndTimes count];
  }
  
  return(result);
  
}

/* ----------------------------------- */

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *result = nil;
  
  if ([tableView isEqual:self.tableViewShakes] == YES){
    
    static NSString *CellIdentifier = @"SimpleCells";
    
    result = [tableView 
              dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (result == nil){
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    /* Get the corresopnding date object for the current row */
    NSDate *dateOfShake = 
    [self.arrayOfShakeDateAndTimes objectAtIndex:indexPath.row];
    
    /* Start formatting the date */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    /* We want Year, Month, Day, Hour, Minute and Second
     out of this NSDate */
    NSDateComponents *dateComponents = 
    [calendar components:
     NSYearCalendarUnit |
     NSMonthCalendarUnit |
     NSDayCalendarUnit |
     NSHourCalendarUnit |
     NSMinuteCalendarUnit |
     NSSecondCalendarUnit
                fromDate:dateOfShake];
    
    /* Place the components into an NSString */
    NSString *detailsText = 
    [NSString stringWithFormat:
     @"At %02ld:%02ld:%02ld on %02ld/%02ld/%04ld", 
     (long)[dateComponents hour],
     (long)[dateComponents minute],
     (long)[dateComponents second],
     (long)[dateComponents day],
     (long)[dateComponents month],
     (long)[dateComponents year]];
   
    /* The title is the same */
    result.textLabel.text = @"Shake Detected";
    
    /* The detailed text is the date and time for every shake */
    result.detailTextLabel.text = detailsText;
    
  }
  
  return(result);
  
}

/* ----------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    NSMutableArray *newArray =
    [[NSMutableArray alloc] init];
    
    arrayOfShakeDateAndTimes = [newArray mutableCopy];
    [newArray release];
    
    self.title = @"Shakes";
    
  }
  
  return(self);
  
}

/* ----------------------------------- */

- (void) detectShakes:(NSNotification *)paramNotification{
  
  if (self.arrayOfShakeDateAndTimes != nil){
    
    [self.arrayOfShakeDateAndTimes addObject:[NSDate date]];
    [self.tableViewShakes reloadData];
    
  } else {
    /* The user shook the device but our array is nil */
  }
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Listen for shake notifications that are 
   getting sent by the window */
  [[NSNotificationCenter defaultCenter] 
   addObserver:self
   selector:@selector(detectShakes:)
   name:NOTIFICATION_SHAKE
   object:nil];
  
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  self.tableViewShakes = nil;
  self.arrayOfShakeDateAndTimes = nil;
  
  /* Stop listening to shake notifications */
  [[NSNotificationCenter defaultCenter] 
   removeObserver:self
   name:NOTIFICATION_SHAKE
   object:nil];
  
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* ----------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ----------------------------------- */

- (void)dealloc {
  
  [arrayOfShakeDateAndTimes release];
  [super dealloc];
}

/* ----------------------------------- */

@end
