//
//  ViewsAndVCAppDelegate.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-10-15.
//  Copyright 2010  All rights reserved.
//

#import "ViewsAndVCAppDelegate.h"
#import "RootViewController.h"

@implementation ViewsAndVCAppDelegate

@synthesize window;
@synthesize navigationController;

/* --------------------- */

- (BOOL)          application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  // Override point for customization after application launch.
  
  RootViewController *rootVC = [[RootViewController alloc] 
                                initWithNibName:@"RootViewController"
                                bundle:nil];
  
  UINavigationController *newNC = [[UINavigationController alloc] 
                                   initWithRootViewController:rootVC];
  
  [rootVC release];
  
  self.navigationController = newNC;
  
  [newNC release];
  
  [self.window addSubview:self.navigationController.view];
  [self.window makeKeyAndVisible];
  
  return YES;
}

/* --------------------- */

- (void)dealloc {
  [navigationController release];
  [window release];
  [super dealloc];
}

/* --------------------- */

@end
