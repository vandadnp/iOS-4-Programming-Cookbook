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

- (void) localeChanged:(NSNotification *)paramNotification{
  
  NSLog(@"Locale Changed");
  
  NSLog(@"%@", [paramNotification object]);
  
  NSLocale *currentLocale = [NSLocale autoupdatingCurrentLocale];
  
  NSLog(@"Current Locale = %@", currentLocale);
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self
     selector:@selector(localeChanged:)
     name:NSCurrentLocaleDidChangeNotification
     object:nil];
    
  }
  
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self isMultitaskingSupported] == YES){
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:NSCurrentLocaleDidChangeNotification
     object:nil];
  }
  
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
  [super dealloc];
}

/* ------------------------------------------- */

@end
