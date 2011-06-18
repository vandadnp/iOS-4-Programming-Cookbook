//
//  MultitaskingAppDelegate.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "MultitaskingAppDelegate.h"
#import "RootViewController.h"

@implementation MultitaskingAppDelegate

/* ------------------------------------------- */

@synthesize window;
@synthesize downloadConnection;
@synthesize connectionDataLength;

/* ------------------------------------------- */

- (void) connection:(NSURLConnection *)connection 
     didReceiveData:(NSData *)data{
  
  NSLog(@"%s", __FUNCTION__);
  
  self.connectionDataLength += [data length];
  
  NSLog(@"Data Length = %ld", (long)self.connectionDataLength);
  
}

/* ------------------------------------------- */

- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response{
  
  NSLog(@"%s", __FUNCTION__);
  
  self.connectionDataLength = 0;
  
}

/* ------------------------------------------- */

- (void) connection:(NSURLConnection *)connection 
   didFailWithError:(NSError *)error{
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (NSURLRequest *)connection:(NSURLConnection *)connection 
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse{
  
  NSLog(@"%s", __FUNCTION__);
  
  return(request);
}

/* ------------------------------------------- */

//- (BOOL)            application:(UIApplication *)application 
//  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
//  
//  self.connectionDataLength = 0;
//  
//  NSString *urlAsString = 
//  @"PUT THE REMOTE URL OF A RATHER BIG FILE HERE";
//  
//  NSURL *url = [NSURL URLWithString:urlAsString];
//  
//  NSURLRequest *request = [NSURLRequest requestWithURL:url];
//  
//  NSURLConnection *newConnection = 
//  [[NSURLConnection alloc] initWithRequest:request
//                                  delegate:self
//                          startImmediately:YES];
//  
//  self.downloadConnection = newConnection;
//  
//  [newConnection release];
//  
//  [window makeKeyAndVisible];
//  
//  return YES;
//}

/* ------------------------------------------- */

//- (BOOL)            application:(UIApplication *)application 
//  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
//  
//  NSString      *urlAsString = 
//  @"PUT THE REMOTE URL OF A VERY BIG FILE HERE";
//  
//  NSURL         *url = [NSURL URLWithString:urlAsString];
//  NSURLRequest  *request = [NSURLRequest requestWithURL:url];
//  NSError       *error = nil;
//  NSURLResponse *response = nil;
//  
//  NSLog(@"Downloading started...");
//  
//  NSData *connectionData = 
//  [NSURLConnection sendSynchronousRequest:request
//                        returningResponse:&response
//                                    error:&error];
//  
//  NSLog(@"Downloading finished");
//  
//  if (connectionData != nil){
//    /* Do something here */
//    NSLog(@"Successfully retrieved the data.");
//  } else {
//    /* Display an error */
//    NSLog(@"Failed to retrieve the data.");
//  }
//  
//  [window makeKeyAndVisible];
//  
//  return YES;
//}

/* ------------------------------------------- */

- (void) downloadFile:(NSURL *)paramURL{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSURLRequest  *request = [NSURLRequest requestWithURL:paramURL];
  NSError       *error = nil;
  NSURLResponse *response = nil;
  
  NSLog(@"Downloading started...");
  
  NSData *connectionData = 
  [NSURLConnection sendSynchronousRequest:request
                        returningResponse:&response
                                    error:&error];
  
  NSLog(@"Downloading finished");
  
  if (connectionData != nil){
    /* Do something here */
    NSLog(@"Successfully retrieved the data.");
  } else {
    /* Display an error */
    NSLog(@"Failed to retrieve the data.");
  }
  
  [pool release];
  
}

/* ------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  NSString      *urlAsString = 
  @"PUT THE REMOTE URL OF A VERY BIG FILE HERE";
  
  NSURL         *url = [NSURL URLWithString:urlAsString];
  
  [NSThread detachNewThreadSelector:@selector(downloadFile:)
                           toTarget:self
                         withObject:url];
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* ------------------------------------------- */

- (void)applicationWillResignActive:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)applicationWillTerminate:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
  if (self.downloadConnection != nil){
    [self.downloadConnection cancel];
  }
  
}

/* ------------------------------------------- */

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  
  NSLog(@"%s", __FUNCTION__);
  
}

/* ------------------------------------------- */

- (void)dealloc {
  [downloadConnection release];
  [window release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
