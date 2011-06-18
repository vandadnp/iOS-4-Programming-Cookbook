//
//  OperationsAppDelegate.m
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import "OperationsAppDelegate.h"
#import "CountingOperation.h"

@implementation OperationsAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize simpleOperation;

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  CountingOperation *newOperation = [[CountingOperation alloc]
                                     initWithStartingCount:0
                                     endingCount:1000];
  self.simpleOperation = newOperation;
  [newOperation release];
  
  [self.simpleOperation start];
  
  /* Print something out just to test if we have to wait
   for the block to execute its code or not */
  NSLog(@"Main thread is here");
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [simpleOperation release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

@end