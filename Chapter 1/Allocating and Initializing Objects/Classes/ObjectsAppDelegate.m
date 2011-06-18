//
//  ObjectsAppDelegate.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-05-26.
//  Copyright  2010. All rights reserved.
//

#import "ObjectsAppDelegate.h"
#import "MyObject.h"

/* --------------------------------------------- */

@implementation ObjectsAppDelegate

/* --------------------------------------------- */

@synthesize window;

/* --------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
  MyObject *someObject = [MyObject alloc];
  /* Do something with the object, call some methods and etc */
  [someObject doSomething];
  [someObject release];
  
  [window makeKeyAndVisible];
	
	return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  [window release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
