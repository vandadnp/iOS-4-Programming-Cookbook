//
//  RootViewController.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ------------------------------------------- */

@implementation RootViewController

/* ------------------------------------------- */

@synthesize myLocationManager;
@synthesize isExecutingInBackground;

/* ------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
  
  NSLog(@"New Location arrived...");
  
  if (self.isExecutingInBackground == YES){
    
    /* Just process the location and do not do any
     heavy processing here */
    
  } else {
    
    /* Display messages, alerts and etc if needed because
     we are not in the background */
    
  }
  
}

/* ------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
  
  NSLog(@"Failed to get location.");
  
  if (self.isExecutingInBackground == YES){
    
    /* Simply note this error and do not display any
     alerts and messages and more importantly, do not
     do any heavy processing here */
    
  } else {
    
    /* maybe display a message to the user */
    
  }
  
}

/* ------------------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil 
                              bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
}

/* ------------------------------------------- */

- (BOOL) isMultitaskingSupported{
  
  BOOL result = NO;
  
  UIDevice *device = [UIDevice currentDevice];
  
  if (device != nil){
    if ([device respondsToSelector:
         @selector(isMultitaskingSupported)] == YES){
      /* Make sure this only gets compiled on iOS SDK 4.0 and
       later so we won't get any compile-time warnings */
      #ifdef __IPHONE_4_0
        #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
          result = [device isMultitaskingSupported];
        #endif
      #endif
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) handleEnteringBackground:(NSNotification *)paramNotification{
  
  /* We have entered background */
  NSLog(@"Going to background.");
  
  self.isExecutingInBackground = YES;
  
  if (self.myLocationManager != nil){
    /* If we are going to the background, let's reduce the accuracy
     of the location manager so that we use less system resources */
    self.myLocationManager.desiredAccuracy = 
    kCLLocationAccuracyHundredMeters;
  }
  
}

/* ------------------------------------------- */

- (void) handleEnteringForeground:(NSNotification *)paramNotification{
  
  /* We have entered foreground */
  NSLog(@"Coming to foreground");
  
  self.isExecutingInBackground = NO;
  
  if (self.myLocationManager != nil){
    /* Now that we are in the foreground, we can increase the accuracy
     of the location manager */
    self.myLocationManager.desiredAccuracy = 
    kCLLocationAccuracyBest;
  }
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Listen for the notifications sent to our application when the
   user puts the application in the background or when 
   the application is brought to the foreground  */
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self
     selector:@selector(handleEnteringBackground:)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleEnteringForeground:)
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
  } else {
    NSLog(@"Multitasking is not enabled.");
  }
  
  /* Now let's create the location manager and start getting
   location change messages */
  CLLocationManager *newManager = [[CLLocationManager alloc] init];
  self.myLocationManager = newManager;
  [newManager release];
  
  self.myLocationManager.delegate = self;
  self.myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
  [self.myLocationManager startUpdatingLocation];
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
  }
  
  /* Get rid of the location manager in cases such as
   a low memory warning */
  if (self.myLocationManager != nil){
    [self.myLocationManager stopUpdatingLocation];
  }
  self.myLocationManager = nil;
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ------------------------------------------- */

- (void)dealloc {
  
  /* make sure we also deallocate our location manager here */
  if (myLocationManager != nil){
    [myLocationManager stopUpdatingLocation];
  }
  [myLocationManager release];
  
  [super dealloc];
}

/* ------------------------------------------- */

@end
