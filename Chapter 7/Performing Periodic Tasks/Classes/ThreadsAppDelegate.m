//
//  ThreadsAppDelegate.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-06-29.
//  Copyright  2010. All rights reserved.
//

#import "ThreadsAppDelegate.h"

@implementation ThreadsAppDelegate

@synthesize window;
@synthesize paintingTimer;

/* -------------------------- */

//- (void) startPainting{
//  
//  NSTimer *newTimer = [NSTimer timerWithTimeInterval:1.0
//                                              target:self
//                                            selector:@selector(paint:)
//                                            userInfo:nil
//                                             repeats:YES];
//  self.paintingTimer = newTimer;
//  
//  /* Do your processing here and whenever you are ready,
//   use the addTimer:forMode instance method of the NSRunLoop class
//   in order to schedule the timer on that run loop */
//  
//  [[NSRunLoop currentRunLoop] addTimer:self.paintingTimer
//                               forMode:NSDefaultRunLoopMode];
//  
//}

/* -------------------------- */

- (void) startPainting{
  
  /* Here is the selector that we want to call */
  SEL selectorToCall = @selector(paint:);
  
  /* Here we compose a method signature out of the selector. We
   know that the selector is in the current class so it is easy
   to construct the method signature */
  NSMethodSignature *methodSignature = 
  [[self class] instanceMethodSignatureForSelector:selectorToCall];
  
  /* Now base our invocation on the method signature. We need this
   invocation to schedule a timer */
  NSInvocation *invocation = 
  [NSInvocation invocationWithMethodSignature:methodSignature];  
  
  [invocation setTarget:self];
  [invocation setSelector:selectorToCall];
  
  NSTimer *newTimer = [NSTimer timerWithTimeInterval:1.0
                                          invocation:invocation 
                                             repeats:YES];
  self.paintingTimer = newTimer;
  
  /* Do your processing here and whenever you are ready,
   use the addTimer:forMode instance method of the NSRunLoop class
   in order to schedule the timer on that run loop */
  
  [[NSRunLoop currentRunLoop] addTimer:self.paintingTimer
                               forMode:NSDefaultRunLoopMode];
  
}

/* -------------------------- */

//- (void) startPainting{
//  
//  NSTimer *newTimer = [NSTimer 
//                       scheduledTimerWithTimeInterval:1.0
//                       target:self
//                       selector:@selector(paint:) 
//                       userInfo:nil
//                       repeats:YES];
//  
//  self.paintingTimer = newTimer;
//  
//}

/* -------------------------- */

//- (void) startPainting{
//  
//  /* Here is the selector that we want to call */
//  SEL selectorToCall = @selector(paint:);
//  
//  /* Here we compose a method signature out of the selector. We
//   know that the selector is in the current class so it is easy
//   to construct the method signature */
//  NSMethodSignature *methodSignature = 
//    [[self class] instanceMethodSignatureForSelector:selectorToCall];
//  
//  /* Now base our invocation on the method signature. We need this
//   invocation to schedule a timer */
//  NSInvocation *invocation = 
//    [NSInvocation invocationWithMethodSignature:methodSignature];
//  [invocation setTarget:self];
//  [invocation setSelector:selectorToCall];
//  
//  /* Start a scheduled timer now */
//  NSTimer *newTimer = 
//  [NSTimer scheduledTimerWithTimeInterval:1.0
//                               invocation:invocation
//                                  repeats:YES];
//  
//  self.paintingTimer = newTimer;
//  
//}

/* -------------------------- */

- (void) paint:(NSTimer *)paramTimer{
  
  /* Do something here */
  NSLog(@"Painting");
  
}

/* -------------------------- */

- (void) stopPainting{
  
  if (self.paintingTimer != nil){
    [self.paintingTimer invalidate];    
  }
  
}

/* -------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  
  [self stopPainting];
  
}

/* -------------------------- */

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
  [self startPainting];
  
}

/* -------------------------- */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
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
  [paintingTimer release];
  [window release];
  [super dealloc];
}


@end
