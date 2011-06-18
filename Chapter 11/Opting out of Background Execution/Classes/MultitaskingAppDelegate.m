//
//  MultitaskingAppDelegate.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "MultitaskingAppDelegate.h"
#import "RootViewController.h"

/* ------------------------------------------- */

@implementation MultitaskingAppDelegate

/* ------------------------------------------- */

@synthesize window;

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSLog(@"%s", __FUNCTION__);
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* ------------------------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidEnterBackground:(UIApplication *)application {

  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationWillTerminate:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)dealloc {
  
  NSLog(@"%s", __FUNCTION__);

  [window release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
