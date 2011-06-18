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

- (NSString *) myMethod:(NSString *)param1 
             withParam2:(NSNumber *)param2{
  
  NSString *result = @"Objective-C";
  
  NSLog(@"Param 1 = %@", param1);
  NSLog(@"Param 2 = %@", param2);
  
  return(result);
}

/* --------------------------------------------- */

- (void) invokeMyMethodDynamically {
  
  SEL selector = @selector(myMethod:withParam2:);
  
  NSMethodSignature *methodSignature = 
  [[self class] instanceMethodSignatureForSelector:selector];
  
  NSInvocation *invocation = 
  [NSInvocation invocationWithMethodSignature:methodSignature];
  [invocation setTarget:self];
  [invocation setSelector:selector];
  
  NSString *returnValue = nil;
  NSString *argument1 = @"First Parameter";
  NSNumber *argument2 = [NSNumber numberWithInt:102];
  
  [invocation setArgument:&argument1 
                  atIndex:2];
  
  [invocation setArgument:&argument2 
                  atIndex:3];
  
  [invocation retainArguments];
  [invocation invoke];
  [invocation getReturnValue:&returnValue];
  
  NSLog(@"Return Value = %@", returnValue);
  
}

/* --------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
  [self invokeMyMethodDynamically];
  
  
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
