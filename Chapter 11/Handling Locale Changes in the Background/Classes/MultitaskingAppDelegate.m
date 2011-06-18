//
//  MultitaskingAppDelegate.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "MultitaskingAppDelegate.h"
#import "RootViewController.h"

@implementation MultitaskingAppDelegate

/* ------------------------------------------- */

@synthesize window;
@synthesize navigationController;

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  RootViewController *Controller = [[RootViewController alloc] initWithNibName:@"RootViewController"
                                                                        bundle:nil];
  
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:Controller];
  
  [Controller release];
  [window addSubview:self.navigationController.view];
  
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
  [self.navigationController release];
  [window release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
