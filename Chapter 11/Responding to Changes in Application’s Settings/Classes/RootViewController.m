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

- (void) settingsChanged:(NSNotification *)paramNotification{
  
  NSLog(@"Settings Changed");
  
  /* The object is of type NSUserDefaults */
  NSLog(@"%@", [paramNotification object]);  
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self
     selector:@selector(settingsChanged:)
     name:NSUserDefaultsDidChangeNotification
     object:nil];
    
  }
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self isMultitaskingSupported] == YES){
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:NSUserDefaultsDidChangeNotification
     object:nil];
  }
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ------------------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ------------------------------------------- */

@end
