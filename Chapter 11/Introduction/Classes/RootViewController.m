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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
}

/* ------------------------------------------- */

- (BOOL) isMultitaskingSupported{
  
  BOOL Result = FALSE;
  
  UIDevice *Device = [UIDevice currentDevice];
  
  if (Device != nil){
    if ([Device respondsToSelector:
         @selector(isMultitaskingSupported)] == YES){
      /* Make sure this only gets compiled on iOS SDK 4.0 and
       later so we won't get any compile-time warnings */
      #ifdef __IPHONE_4_0
        #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
          Result = [Device isMultitaskingSupported];
        #endif
      #endif
    }
  }
  
  return(Result);
  
}

/* ------------------------------------------- */

- (void) handleEnteringBackground:(NSNotification *)paramNotification{
  
  /* We have entered background */
  NSLog(@"Going to background.");
  
}

/* ------------------------------------------- */

- (void) handleEnteringForeground:(NSNotification *)paramNotification{
  
  /* We have entered foreground */
  NSLog(@"Coming to foreground");
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
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
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

/* ------------------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ------------------------------------------- */

@end
