//
//  Project3AppDelegate.m
//  Project3
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright  2010. All rights reserved.
//

#import "Project3AppDelegate.h"
#import "Project3ViewController.h"

/* -------------------------- */

@implementation Project3AppDelegate

/* -------------------------- */

@synthesize window;
@synthesize viewController;
@synthesize navigationController;

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  
  UINavigationController *theNavigationController = 
  [[UINavigationController alloc]
   initWithRootViewController:self.viewController];
  
  self.navigationController = theNavigationController;
  
  [theNavigationController release];
  
  [self.navigationController setNavigationBarHidden:NO
                                           animated:YES];
  
  [window addSubview:self.navigationController.view];
  [window makeKeyAndVisible];
  
	return YES;
}

/* -------------------------- */

- (void)dealloc {
  [navigationController release];
  [viewController release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

@end
