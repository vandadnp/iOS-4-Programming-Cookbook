//
//  ViewsAndVCAppDelegate.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import "ViewsAndVCAppDelegate.h"
#import "FirstViewController.h"

/* -------------------------- */

@implementation ViewsAndVCAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize navigationController;

/* -------------------------- */

- (BOOL)  application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  // Override point for customization after application launch.
  FirstViewController *controller = 
  [[FirstViewController alloc]
   initWithNibName:@"FirstViewController"
   bundle:nil];
  
  UINavigationController *theNavigationController = 
  [[UINavigationController alloc] 
   initWithRootViewController:controller];
  
  self.navigationController = theNavigationController;
  
  [theNavigationController release];
  
  [self.navigationController setNavigationBarHidden:NO
                                           animated:YES];
  
  [controller release];
  
  // Add the view controller's view to the window and display.
  [window addSubview:self.navigationController.view];
  [window makeKeyAndVisible];
  
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [navigationController release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

@end
