//
//  MultitaskingAppDelegate.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "MultitaskingAppDelegate.h"

/* ------------------------------------------- */

@implementation MultitaskingAppDelegate

/* ------------------------------------------- */

@synthesize window;
@synthesize backgroundTaskIdentifier;

/* ------------------------------------------- */

- (BOOL) isMultitaskingSupported{
  
  BOOL result = NO;
  
  UIDevice *device = [UIDevice currentDevice];
  
  if (device != nil){
    if ([device respondsToSelector:
         @selector(isMultitaskingSupported)] == YES){
      /* Make sure this only gets compiled on iOS SDK 4.0 and
       later so we won't get any compile-time warnings */
      #ifdef __IPHONE_4_0
        #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
          result = [device isMultitaskingSupported];
        #endif
      #endif
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) myThread{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  /* Just run for as long as nobody has cancelled this thread */
  while ([[NSThread currentThread] isCancelled] == NO){
    
    [NSThread sleepForTimeInterval:1.0f];
    
    if ([[NSThread currentThread] isCancelled] == NO){
      
      /* Print out how much time we have left */
      if ([[UIApplication sharedApplication] 
           backgroundTimeRemaining] == DBL_MAX){
        NSLog(@"Remaining time = Infinite");
      } else {
        NSLog(@"Remaining time = %02.02F seconds",
              [[UIApplication sharedApplication] 
               backgroundTimeRemaining]);
      }
      
    }
    
  }
  
  [pool release];
  
}

/* ------------------------------------------- */

- (void) endBackgroundTask:(NSNumber *)paramIdentifier{
  
  /* We are asked to end the given background task
   by its identifier */
  
  UIBackgroundTaskIdentifier identifier =
  [paramIdentifier integerValue];
  
  [[UIApplication sharedApplication] 
   endBackgroundTask:identifier];
  
}

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  /* Start a new thread that prints out the number of
   seconds our application has left to execute code
   before it is sent to the background */
  
  [NSThread detachNewThreadSelector:@selector(myThread)
                           toTarget:self
                         withObject:nil];
  
  [window makeKeyAndVisible];
  
  return(YES);
}

/* ------------------------------------------- */

- (void)applicationDidEnterBackground:(UIApplication *)application {

  /* Start a long running task */
  
  if ([self isMultitaskingSupported] == NO){
    return;
  }
  
  self.backgroundTaskIdentifier = 
  [[UIApplication sharedApplication] 
   beginBackgroundTaskWithExpirationHandler:^{
    /* Make sure our identifier is a valid one */
    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
      
      /* Now attempt to end the task whenever the system asks us */
      
      NSNumber *taskIdentifier = [NSNumber numberWithInteger:
                                  self.backgroundTaskIdentifier];
      
      [self performSelectorOnMainThread:@selector(endBackgroundTask:)
                             withObject:taskIdentifier
                          waitUntilDone:YES];
      
      /* Mark this task as done/invalid */
      self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }
  }];
    
}

/* ------------------------------------------- */

- (void)applicationWillEnterForeground:(UIApplication *)application {

  /* When the application comes to the foreground again, we HAVE to
   check if we had previously borrowed some time from iOS. If so, we
   have to mark that task as done */
  
  if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
    [[UIApplication sharedApplication] 
     endBackgroundTask:self.backgroundTaskIdentifier];
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
  }
  
}

/* ------------------------------------------- */

- (void)dealloc {
  [window release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
