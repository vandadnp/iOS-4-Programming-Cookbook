//
//  OperationsAppDelegate.m
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import "OperationsAppDelegate.h"

@implementation OperationsAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize simpleOperation;

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  /* Here is our block */
  NSBlockOperation *newBlockOperation = 
  [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Current Thread = %@", [NSThread currentThread]);
    NSUInteger counter = 0;
    for (counter = 0;
         counter < 1000;
         counter++){
      NSLog(@"Count = %lu", (unsigned long)counter);
    }
  }];
  
  /* Make sure we keep the reference somewhere */
  self.simpleOperation = newBlockOperation;
  
  /* Start the operation */
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