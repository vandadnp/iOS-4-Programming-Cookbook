    //
//  RootViewController.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import <objc/runtime.h>

/* --------------------------------------------- */

@implementation RootViewController

/* --------------------------------------------- */

@synthesize locationManager;

/* --------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
  
  /* We received the new location */
  
  NSLog(@"Latitude = %f", newLocation.coordinate.latitude);
  NSLog(@"Longitude = %f", newLocation.coordinate.longitude);
  
}

/* --------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
  
  /* Failed to receive user's location */
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  BOOL locationServicesAreEnabled = NO;
  
  Method requiredClassMethod = 
  class_getClassMethod([CLLocationManager class], 
                       @selector(locationServicesEnabled));
  
  if (requiredClassMethod != nil){
    
    locationServicesAreEnabled =
    [CLLocationManager locationServicesEnabled];
    
  } else {
    
    CLLocationManager *DummyManager = 
    [[CLLocationManager alloc] init];
    
    locationServicesAreEnabled = [DummyManager locationServicesEnabled];
    [DummyManager release];
    
  }
  
  if (locationServicesAreEnabled == YES){
    
    CLLocationManager *newLocationManager = 
    [[CLLocationManager alloc] init];
    
    self.locationManager = newLocationManager;
    
    [newLocationManager release];
    
    self.locationManager.delegate = self;
    
    self.locationManager.purpose = 
      NSLocalizedString(@"To provide functionality based on\
                        user's current location.", nil);
    
    [self.locationManager startUpdatingLocation];
    
  } else {
    
    /* Location services are not enabled.
     Take appropriate action: for instance, prompt the
     user to enable the location services */
    NSLog(@"Location services are not enabled");
    
  }

}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  if (self.locationManager != nil){
    [self.locationManager stopUpdatingLocation];
  }
  
  self.locationManager = nil;
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  [locationManager stopUpdatingLocation];
  [locationManager release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
