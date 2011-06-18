    //
//  RootViewController.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "MyAnnotation.h"

@implementation RootViewController

/* --------------------------------------------- */

@synthesize myMapView;

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create a map as big as our view */
  MKMapView *newMapView = [[MKMapView alloc] 
                           initWithFrame:self.view.bounds];
  self.myMapView = newMapView;
  [newMapView release];
  
  self.myMapView.delegate = self;
  
  /* Set the map type to Standard */
  self.myMapView.mapType = MKMapTypeStandard;
  
  self.myMapView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
  
  /* Add it to our view */
  [self.view addSubview:self.myMapView];
  
  /* This is just a sample location */
  CLLocationCoordinate2D location;
  location.latitude = 50.82191692907181;
  location.longitude = -0.13811767101287842;
  
  /* Create the annotation using the location */
  MyAnnotation *annotation = 
  [[MyAnnotation alloc] initWithCoordinates:location
                                      title:@"My Title"
                                   subTitle:@"My Sub Title"];
  
  /* And eventually add it to the map */
  [self.myMapView addAnnotation:annotation];
  
  [annotation release];
  
}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  self.myMapView = nil;
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  [myMapView release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
