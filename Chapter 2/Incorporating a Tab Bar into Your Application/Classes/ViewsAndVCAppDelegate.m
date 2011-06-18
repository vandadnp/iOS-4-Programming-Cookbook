//
//  ViewsAndVCAppDelegate.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import "ViewsAndVCAppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

/* -------------------------- */

@implementation ViewsAndVCAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize tabBarController;

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  /* Create the first View Controller */
  FirstViewController *firstController = 
  [[FirstViewController alloc] 
   initWithNibName:@"FirstViewController" 
   bundle:nil];
  
  /* Now create the second View Controller */
  SecondViewController *secondController = 
  [[SecondViewController alloc] 
   initWithNibName:@"SecondViewController" 
   bundle:nil];
  
  /* Stack up all the View Controllers into an array */
  NSArray *arrayofViewControllers = [NSArray arrayWithObjects:
                                     firstController,
                                     secondController,
                                     nil];
  
  [firstController release];
  [secondController release];
  
  /* Instantiate your Tab Bar Controller */
  UITabBarController *theTabBarController = 
  [[UITabBarController alloc] init];
  
  self.tabBarController = theTabBarController;
  [theTabBarController release];
  
  /* Set the array of View Controllers of the Tab Bar Controller */
  [self.tabBarController setViewControllers:arrayofViewControllers
                              animated:YES];
  
  /* Show the View of the Tab Bar Controller */
  [window addSubview:self.tabBarController.view];
  
  [window makeKeyAndVisible];
  
  return YES;
  
}

/* -------------------------- */

- (void)dealloc {
  [tabBarController release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

@end
