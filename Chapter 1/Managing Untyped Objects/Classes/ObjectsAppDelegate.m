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
	
  /* The MyBundle variable is of type NSBundle */
  NSBundle *myBundle = [NSBundle mainBundle];
  
  /* The UntypedObject is of type id, an untyped object indeed */
  id untypedObject = myBundle;
  
  /* We now get the class of our untyped object */
  Class untypedObjectClass = [untypedObject class];
  
  /* Do a comparison here */
  if ([untypedObjectClass isEqual:[NSBundle class]] == YES){
    /* This is an object of type NSBundle */
  } else {
    /* Process other classes... */
  }
  
  
  
  
//  NSNumber *integerNumber = [NSNumber numberWithInt:10];
//  NSNumber *boolNumber = [NSNumber numberWithBool:10];
//  NSNumber *longNumber = [NSNumber numberWithLong:10];
//  
//  NSLog(@"%@", NSStringFromClass([integerNumber class]));
//  NSLog(@"%@", NSStringFromClass([boolNumber class]));
//  NSLog(@"%@", NSStringFromClass([longNumber class]));
  
  NSNumber *integerNumber = [NSNumber numberWithInt:10];
  NSNumber *boolNumber = [NSNumber numberWithBool:10];
  NSNumber *longNumber = [NSNumber numberWithLong:10];  
  
  if ([integerNumber isKindOfClass:[NSNumber class]] &&
      [boolNumber isKindOfClass:[NSNumber class]] &&
      [longNumber isKindOfClass:[NSNumber class]]){
    NSLog(@"They are all of type NSNumber.");
  } else {
    NSLog(@"They are not all of type NSNumber.");
  }
  
  
  
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
