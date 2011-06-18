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
  
  BOOL result = NO;
  
  UIDevice *Device = [UIDevice currentDevice];
  
  if (Device != nil){
    if ([Device respondsToSelector:
         @selector(isMultitaskingSupported)] == YES){
      /* Make sure this only gets compiled on iOS SDK 4.0 and
       later so we won't get any compile-time warnings */
      #ifdef __IPHONE_4_0
        #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
          result = [Device isMultitaskingSupported];
        #endif
      #endif
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) doTask1{
  
  int Counter = 0;
  for (Counter = 0;
       Counter < 1000;
       Counter++){
    NSLog(@"Task 1");
  }
  
}

- (void) doTask2{
  
  int Counter = 0;
  for (Counter = 0;
       Counter < 1000;
       Counter++){
    NSLog(@"Task 2");
  }
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self isMultitaskingSupported] == YES){
    NSLog(@"Multitasking is enabled.");
  } else {
    NSLog(@"Multitasking is not enabled.");
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

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

/* ------------------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ------------------------------------------- */

@end
