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
@synthesize connectionData;

/* -------------------------- */

- (void)          connection:(NSURLConnection *)connection
            didFailWithError:(NSError *)error{
  
  NSLog(@"An error happened");
  NSLog(@"%@", error);
  
}

/* -------------------------- */

- (void)          connection:(NSURLConnection *)connection
              didReceiveData:(NSData *)data{
  
  NSLog(@"Received data");
  [self.connectionData appendData:data];
  
}

/* -------------------------- */

- (void)        connectionDidFinishLoading
               :(NSURLConnection *)connection{
  
  NSLog(@"Successfully downloaded the contents of the URL.");
  
  /* do something with the data here */
  
}

/* -------------------------- */

- (void)          connection:(NSURLConnection *)connection
          didReceiveResponse:(NSURLResponse *)response{
  
  [self.connectionData setLength:0];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *urlAsString = @"http://www.OReilly.com";
  
  NSURL    *url = [NSURL URLWithString:urlAsString];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
  
  /* The object where we will store the data that 
   is being downloaded */
  NSMutableData *data = [[NSMutableData alloc] init];
  self.connectionData = data;
  [data release];
  
  NSURLConnection *newConnection = [[NSURLConnection alloc] 
                                    initWithRequest:request
                                    delegate:self
                                    startImmediately:YES];
  self.connection = newConnection;
  [newConnection release];
  
  if (self.connection != nil){
    /* Successfully created the connection */
  } else {
    /* Could not create the connection */
  }
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  [self.connection cancel];
  self.connection = nil;
  self.connectionData = nil;
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  
  
  if (connection != nil){
    [connection cancel];
  }
  
  [connection release];
  [connectionData release];
  
  [super dealloc];
}

/* -------------------------- */

@end
