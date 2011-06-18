//
//  ObjectsAppDelegate.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-05-26.
//  Copyright  2010. All rights reserved.
//

#import "ObjectsAppDelegate.h"

/* --------------------------------------------- */

@implementation ObjectsAppDelegate

/* --------------------------------------------- */

@synthesize window;

/* --------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
  /* After this line:
   foo's retain count is 1 */
  NSObject *foo = [[NSObject alloc] init];
  NSLog(@"%lu", (unsigned long)[foo retainCount]);
  
  /* After this line:
   foo's retain count = 2
   bar is equal to foo */
  NSObject *bar = [foo retain];
  NSLog(@"%lu", (unsigned long)[foo retainCount]);
  
  /* After this line:
   foo's retain count = 2
   bar is equal to foo
   baz is equal to bar and foo */
  NSObject *baz = bar;
  NSLog(@"%lu", (unsigned long)[foo retainCount]);
  
  /* After this line:
   baz's retain count = 1
   bar's retain count = 1
   foo's retain count = 1 */
  [baz release];
  
  /* After this line:
   foo, bar and baz are deallocated here and
   should not be referenced */
  [bar release];
  
  [window makeKeyAndVisible];
	
	return YES;
}

/* --------------------------------------------- */


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
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
