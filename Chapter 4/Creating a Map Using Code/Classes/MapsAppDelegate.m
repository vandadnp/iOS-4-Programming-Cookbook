//
//  MapsAppDelegate.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-07.
//  Copyright  2010. All rights reserved.
//

#import "MapsAppDelegate.h"
#import "RootViewController.h"

@implementation MapsAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch
  
  
  
  RootViewController *Controller = [[[RootViewController alloc] initWithNibName:@"RootViewController" 
                                                                         bundle:nil] autorelease];
  
  NavigationController = [[UINavigationController alloc] initWithRootViewController:Controller];
  NavigationController.navigationBarHidden = TRUE;
  
	[window addSubview:NavigationController.view];
  [window makeKeyAndVisible];
  
    return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
