//
//  ThreadsAppDelegate.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-06-29.
//  Copyright  2010. All rights reserved.
//

#import "ThreadsAppDelegate.h"
#import "RootViewController.h"

@implementation ThreadsAppDelegate

@synthesize window;
@synthesize navigationController;

/* -------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  
}

/* -------------------------- */

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}

/* -------------------------- */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  
  RootViewController *Controller = [[RootViewController alloc] initWithNibName:@"RootViewController"
                                                                        bundle:nil];
  
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:Controller];
  
  [Controller release];

  
  [window addSubview:self.navigationController.view];
  
  [window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}



- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
