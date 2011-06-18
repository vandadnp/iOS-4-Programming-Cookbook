//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* This is the URL which we want to download the contents of */
  NSString *urlAsString = @"http://www.OReilly.com";
  
  NSURL    *url = [NSURL URLWithString:urlAsString];
  
  /* Create the request to pass to NSURLConnection */
  NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
  
  NSError *error = nil;
  
  /* Block the current thread with the synchronous connection */
  NSData   *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:&error];
  
  /* Did we get the data? */
  if (data != nil){
    /* Let's make an NSString out of the data */
    NSString *dataAsString = 
    [[NSString alloc] initWithData:data
                          encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", dataAsString);
    
    [dataAsString release];
    
  } else {
    
    /* We could not get the data */
    NSLog(@"%@", error);
    
  } /* if (Data != nil){ */
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (TRUE);
}

/* -------------------------- */

- (void)dealloc {
  
  
  [super dealloc];
}

/* -------------------------- */

@end
