//
//  MultitaskingAppDelegate.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "MultitaskingAppDelegate.h"

/* ------------------------------------------- */

@implementation MultitaskingAppDelegate

/* ------------------------------------------- */

@synthesize window;

/* ------------------------------------------- */

- (BOOL) localNotificationWithMessage
      :(NSString *)paramMessage
      actionButtonTitle:(NSString *)paramActionButtonTitle
      launchImage:(NSString *)paramLaunchImage
      applicationBadge:(NSInteger)paramApplicationBadge
      howManySecondsFromNow:(NSTimeInterval)paramHowManySecondsFromNow
      userInfo:(NSDictionary *)paramUserInfo{
  
  UILocalNotification *notification = 
  [[UILocalNotification alloc] init];
  
  notification.alertBody = paramMessage;
  
  notification.alertAction = paramActionButtonTitle;
  
  if (paramActionButtonTitle != nil &&
      [paramActionButtonTitle length] > 0){
    /* Make sure we have the action button for the user to press
     to open our application */
    notification.hasAction = YES;
  } else {
    notification.hasAction = NO;
  }
  
  /* Here you have a chance to change the launch 
   image of your application when the notification's
   action is viewed by the user */
  notification.alertLaunchImage = paramLaunchImage;
  
  /* Change the badge number of the application once the
   notification is presented to the user. Even if the user
   dismisses the notification, the badge number of the
   application will change */
  notification.applicationIconBadgeNumber = paramApplicationBadge;
  
  /* This dictionary will get passed to your application
   later if and when the user decides to view this notification */
  notification.userInfo = paramUserInfo;
  
  /* We need to get the system time zone so that the alert view
   will adjust its fire date if the user's time zone changes */
  NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
  notification.timeZone = timeZone;
  
  /* Schedule the delivery of this notification 10 seconds from
   now */
  NSDate *fireDate = [NSDate date];
  
  fireDate = 
  [fireDate dateByAddingTimeInterval:paramHowManySecondsFromNow];
  
  NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
  
  NSUInteger dateComponents = NSYearCalendarUnit |
                              NSMonthCalendarUnit |
                              NSDayCalendarUnit |
                              NSHourCalendarUnit |
                              NSMinuteCalendarUnit |
                              NSSecondCalendarUnit;
  
  NSDateComponents *components = [calendar components:dateComponents
                                             fromDate:fireDate];
  
  /* Here you have a chance to change these components. That's why we
   retrieved the components of the date in the first place. */
  
  fireDate = [calendar dateFromComponents:components];
  
  /* Finally set the schedule date for this notification */
  notification.fireDate = fireDate;
  
  [[UIApplication sharedApplication] 
   cancelAllLocalNotifications];
  
  [[UIApplication sharedApplication]
   scheduleLocalNotification:notification];
  
  [notification release];
  
  return(YES);
  
}

/* ------------------------------------------- */

- (void) displayAlertWithTitle:(NSString *)paramTitle
                       message:(NSString *)paramMessage{
  
  UIAlertView *alertView = [[[UIAlertView alloc] 
                             initWithTitle:paramTitle
                             message:paramMessage
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil] autorelease];
  [alertView show];
  
}

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  id    scheduledLocalNotification = nil;
  
  scheduledLocalNotification = 
  [launchOptions 
   valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
  
  if (scheduledLocalNotification != nil){
    
    /* We received a local notification while 
     our application wasn't running. You can now typecase the
     ScheduledLocalNotification variable to UILocalNotification and
     use it in your application */
    
    [self displayAlertWithTitle:@"Notification"
                        message:@"Local Notification Woke Us Up"];
    
  } else {
    
    NSString *message = 
    NSLocalizedString(@"A new instant message is available. \
                      Would you like to read this message?", nil);
    
    /* If a local notification didn't start our application,
     then we start a new local notification */
    [self localNotificationWithMessage:message
                     actionButtonTitle:nil
                           launchImage:nil
                      applicationBadge:1
                 howManySecondsFromNow:10
                              userInfo:nil];
    
    [self displayAlertWithTitle:@"Set Up"
                     message:@"A new Local Notification is set up \
                               to be displayed 10 seconds from now"];
    
  }
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* ------------------------------------------- */

- (void)          application:(UIApplication *)application 
  didReceiveLocalNotification:(UILocalNotification *)notification{
  
  /* We will receive this message whenever our application
   is running in the background when the local notification
   is delivered. If the application is terminated and the
   local notification is viewed by the user, the
   application:didFinishLaunchingWithOptions: method will be
   called and the notification will be passed via the
   didFinishLaunchingWithOptions parameter */
  
  [self displayAlertWithTitle:@"Local Notification"
                      message:@"The Local Notification is delivered."];
  
}

/* ------------------------------------------- */

- (void)dealloc {
  [window release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
