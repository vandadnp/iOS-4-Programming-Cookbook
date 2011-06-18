//
//  TablesAppDelegate.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright  2010. All rights reserved.
//

#import "TablesAppDelegate.h"
#import "RootViewController.h"

@implementation TablesAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

  RootViewController *Controller = [[RootViewController alloc] initWithNibName:@"RootViewController"
                                                                        bundle:nil];
  navigationController = [[UINavigationController alloc] initWithRootViewController:Controller];
  [Controller release];

  [window addSubview:navigationController.view];
	
  [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
