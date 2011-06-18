    //
//  RootViewController.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* --------------------------------------------- */

@implementation RootViewController

/* --------------------------------------------- */

@synthesize myMapView;

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create a map as big as our view */
  MKMapView *mapView = [[MKMapView alloc] 
                        initWithFrame:self.view.bounds];
  self.myMapView = mapView;
  [mapView release];
  
  /* Set the map type to Satellite */
  self.myMapView.mapType = MKMapTypeSatellite;
  
  self.myMapView.delegate = self;
  
  self.myMapView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth | 
    UIViewAutoresizingFlexibleHeight;
  
  /* Add it to our view */
  [self.view addSubview:self.myMapView];
  
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

