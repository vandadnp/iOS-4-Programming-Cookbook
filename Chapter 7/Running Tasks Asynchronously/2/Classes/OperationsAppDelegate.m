//
//  OperationsAppDelegate.m
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import "OperationsAppDelegate.h"
#import "SimpleOperation.h"

@implementation OperationsAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize firstOperation;
@synthesize secondOperation;
@synthesize operationQueue;

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSNumber *firstNumber = [NSNumber numberWithInteger:111];
  NSNumber *secondNumber = [NSNumber numberWithInteger:222];

  SimpleOperation *operationOne = 
  [[SimpleOperation alloc]
   initWithObject:firstNumber];
  self.firstOperation = operationOne;
  [operationOne release];
  
  SimpleOperation *operationTwo = 
  [[SimpleOperation alloc]
   initWithObject:secondNumber];
  self.secondOperation = operationTwo;
  [operationTwo release];
  
  /* Instantiate the opertion queue */
  NSOperationQueue  *newOperationQueue = 
  [[NSOperationQueue alloc] init];
  self.operationQueue = newOperationQueue;
  [newOperationQueue release];
  
  /* Add the operations to the queue */
  [self.operationQueue addOperation:self.firstOperation];
  [self.operationQueue addOperation:self.secondOperation];
  
  NSLog(@"Main thread is here");
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [firstOperation release];
  [secondOperation release];
  [operationQueue release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
   */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  /*
   Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   See also applicationDidEnterBackground:.
   */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


@end
