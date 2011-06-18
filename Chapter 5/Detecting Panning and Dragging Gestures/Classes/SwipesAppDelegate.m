//
//  SwipesAppDelegate.m
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright  2010. All rights reserved.
//

#import "SwipesAppDelegate.h"
#import "RootViewController.h"

@implementation SwipesAppDelegate

@synthesize window, NavigationController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
  RootViewController *Controller = [[RootViewController alloc] initWithNibName:@"RootViewController"
                                                                        bundle:nil];
  
  self.NavigationController = [[UINavigationController alloc] initWithRootViewController:Controller];
  
  [Controller release];
  [window addSubview:self.NavigationController.view];
	
  [window makeKeyAndVisible];
    
  return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
