//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

/* -------------------------- */

@implementation RootViewController

/* -------------------------- */

@synthesize connection;

/* -------------------------- */

- (void)  connection:(NSURLConnection *)connection 
  didReceiveResponse:(NSURLResponse *)response{
  
  NSLog(@"Did Receive Response");
  
}

/* -------------------------- */

- (NSURLRequest *)connection:(NSURLConnection *)connection 
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse{
  
  NSLog(@"Will Send Request");
  
  
  return(request);  
  
}

/* -------------------------- */

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)data{
  
  NSLog(@"Did Receive Data");
  
  NSLog(@"Data Length = %lu", (unsigned long)[data length]);
  
}

/* -------------------------- */

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection 
   willCacheResponse:(NSCachedURLResponse *)cachedResponse{
  
  NSLog(@"Will Cache Response");
  
  return(cachedResponse);
  
}

/* -------------------------- */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  
  NSLog(@"Did Finish Loading.");
  
}

/* -------------------------- */

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error{
  
  NSLog(@"Did Fail With Error");
  
}

/* -------------------------- */

- (void) downloadURL:(NSString *)paramURLAsString{
  
  if ([paramURLAsString length] == 0){
    NSLog(@"Nil or empty URL is given");
    return;
  }
  
  /* Get the shared URL Cache object. No need to create a new one */
  NSURLCache *urlCache = [NSURLCache sharedURLCache];
  
  /* We will store up to 1 Megabytes of data into the cache */
  [urlCache setMemoryCapacity:1*1024*1024];
  
  /* For our request, we need an instance of NSURL so let's retrieve
   that from the string that we created before */
  NSURL *url = [NSURL URLWithString:paramURLAsString];
  
  /* And this is our request */
  NSMutableURLRequest *request = 
  [NSMutableURLRequest 
   requestWithURL:url
   cachePolicy:NSURLRequestUseProtocolCachePolicy
   timeoutInterval:60.0f];
  
  /* Try to get a cached response to our request. 
   This might come back as nil */
  NSCachedURLResponse *response = 
  [urlCache cachedResponseForRequest:request];
  
  /* Do we have a cached response? */
  if (response != nil){
    NSLog(@"Cached response exists. Loading data from cache...");
    [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
  }
  
  self.connection = nil;
  
  /* Start the connection with the request */
  NSURLConnection *newConnection = 
  [[NSURLConnection alloc] initWithRequest:request
                                  delegate:self
                          startImmediately:YES];
  
  self.connection = newConnection;
  [newConnection release];
  
}

/* -------------------------- */

- (IBAction) downloadData:(id)paramSender{
  
  [self downloadURL:@"http://www.OReilly.com"];

}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  self.connection = nil;
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (TRUE);
}

/* -------------------------- */

- (void)dealloc {
  if (connection != nil){
    [connection cancel];
  }
  [connection release];
  [super dealloc];
  
}

/* -------------------------- */

@end
