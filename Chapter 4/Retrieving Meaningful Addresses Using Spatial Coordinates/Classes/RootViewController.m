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

@synthesize myReverseGeocoder;

/* --------------------------------------------- */

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder 
       didFindPlacemark:(MKPlacemark *)placemark{
  
  /* We received the results */
  NSLog(@"%@", placemark.country);
  NSLog(@"%@", placemark.postalCode);
  NSLog(@"%@", placemark.locality);

}

/* --------------------------------------------- */

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder 
       didFailWithError:(NSError *)error{
  
  /* An error has occurred. Use the [error] parameter to 
   determine the cause of the issue */
  NSLog(@"An error occurred in the reverse geocoder");
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
  CLLocationCoordinate2D location;
  location.latitude = +38.4112810;
  location.longitude = -122.8409780f;
  
  MKReverseGeocoder *reverseGeocoder = 
  [[MKReverseGeocoder alloc] initWithCoordinate:location];
  
  self.myReverseGeocoder = reverseGeocoder;
  
  [reverseGeocoder release];
  
  self.myReverseGeocoder.delegate = self;
  [self.myReverseGeocoder start];

}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  [self.myReverseGeocoder cancel];
  self.myReverseGeocoder = nil;
  
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  [myReverseGeocoder cancel];
  [myReverseGeocoder release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
