//
//  AppDelegate_iPhone.m
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-24.
//  Copyright 2010  All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "RootViewController_iPhone.h"

/* ------------------------------------------- */

@implementation AppDelegate_iPhone

/* ------------------------------------------- */

@synthesize navigationController;

/* ------------------------------------------- */

- (BOOL)                application:(UIApplication *)application
      didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  /* Create a Navigation Controller and initialize it with
   the root View Controller */
  
  RootViewController_iPhone *Controller = 
  [[RootViewController_iPhone alloc] initWithNibName:@"RootViewController_iPhone"
                                              bundle:nil];
  
  self.navigationController = 
  [[UINavigationController alloc] 
   initWithRootViewController:Controller];
  
  [Controller release];
  
  [window addSubview:self.navigationController.view];

  [window makeKeyAndVisible];
  
  NSLog(@"%s", __FUNCTION__);
  
  return YES;
}

/* ------------------------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
	[super applicationDidEnterBackground:application];
  
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
  
	[super applicationWillTerminate:application];
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

  [super applicationDidReceiveMemoryWarning:application];
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)dealloc {
  
	[self.navigationController release];
	[super dealloc];
  
  NSLog(@"%s", __FUNCTION__);
}

/* ------------------------------------------- */

@end

