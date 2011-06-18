//
//  RootViewController.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

/* --------------------------------------------- */

@synthesize myConnection, connectionData;

/* --------------------------------------------- */

- (void)connection:(NSURLConnection *)connection 
  didFailWithError:(NSError *)error{
  
  /* Handle the error here */
  NSLog(@"Connection error happened");
  
}

/* --------------------------------------------- */

- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response{
  
  [self.connectionData setLength:0];
  
}

/* --------------------------------------------- */

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)data{
  
  /* We received some data, let's append it to the end of the
   currrent mutable data that we have */
  [self.connectionData appendData:data];
  
}

/* --------------------------------------------- */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  
  NSString *connectionString = 
    [[NSString alloc] initWithData:self.connectionData
                          encoding:NSUTF8StringEncoding];
  
  if ([connectionString length] > 0){
    
    NSArray *components = 
    [connectionString 
     componentsSeparatedByString:@","];
    
    NSString *statusCode = nil, 
             *accuracy = nil, 
             *latitude = nil,
             *longitude = nil;
    
    if ([components count] == 4){
      
      statusCode = [components objectAtIndex:0];
      accuracy = [components objectAtIndex:1];
      latitude = [components objectAtIndex:2];
      longitude = [components objectAtIndex:3];
      
      NSLog(@"Status Code = %@", statusCode);
      NSLog(@"Accuracy = %@", accuracy);
      NSLog(@"Latitude = %@", latitude);
      NSLog(@"Longitude = %@", longitude);
            
    } else {
      /* Handle other situation where we have more or less
       than 4 values which we expect from this API */
    }
    
  } else {
    /* The string is empty, handle this problem here */
  }
  
  [connectionString release];
  connectionString = nil;
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
  /* We have our address */
  NSString *oreillyAddress = 
    @"1005 Gravenstein Highway North, Sebastopol, CA 95472, USA";
  
  /* We will later insert the address and the format that we want
   our output in, into this API's URL */
  NSString *geocodingURL = 
  @"http://maps.google.com/maps/geo?q=%@&output=%@";
  
  /* Insert the address and the output format into the URL */
  NSString *finalURL = 
  [NSString stringWithFormat:geocodingURL, 
   oreillyAddress, 
   GOOGLE_OUTPUT_FORMAT_CSV];
  
  /* Now escape the URL using appropriate percentage marks */
  finalURL = 
    [finalURL 
     stringByAddingPercentEscapesUsingEncoding:
     NSUTF8StringEncoding];
  
  /* Create our URL */
  NSURL *urlToCall = [NSURL URLWithString:finalURL];
  
  /* And a request for the connection using the URl */
  NSURLRequest *request = [NSURLRequest requestWithURL:urlToCall];
  
  /* We will put all the connection's received data into this
   instance of the NSMutableData class */
  NSMutableData *newMutableData = [[NSMutableData alloc] init];
  self.connectionData = newMutableData;
  [newMutableData release];
  
  NSURLConnection *newConnection = 
  [[NSURLConnection alloc] initWithRequest:request 
                                  delegate:self];
  
  /* Create the connection and start the downloading 
   of geocoding results */
  self.myConnection = newConnection;
  
  [newConnection release];
  
}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  [self.myConnection cancel];
  
  self.myConnection = nil;
  self.connectionData = nil;
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  
  [myConnection cancel];
  [myConnection release];
  [connectionData release];
  
  [super dealloc];
}

/* --------------------------------------------- */

@end