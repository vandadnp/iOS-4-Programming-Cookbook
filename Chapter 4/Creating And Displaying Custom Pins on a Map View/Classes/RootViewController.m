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

@synthesize myMapView, locationManager;

/* --------------------------------------------- */

- (MKAnnotationView *)mapView:(MKMapView *)mapView 
            viewForAnnotation:(id <MKAnnotation>)annotation{
  
  MKAnnotationView *result = nil;
  
  if ([annotation isKindOfClass:[MyAnnotation class]] == NO){
    return(result);
  }
  
  if ([mapView isEqual:self.myMapView] == NO){
    /* We want to process this event only for the Map View
     that we have created previously */
    return(result);
  }
  
  /* First typecast the annotation for which the Map View has
   fired this delegate message */
  MyAnnotation *senderAnnotation = (MyAnnotation *)annotation;
  
  /* Using the class method we have defined in our custom
   annotation class, we will attempt to get a reusable
   identifier for the pin we are about to create */
  NSString *pinReusableIdentifier = 
  [MyAnnotation 
   reusableIdentifierforPinColor:senderAnnotation.pinColor];
  
  /* Using the identifier we retrieved above, we will
   attempt to reuse a pin in the sender Map View */
  MKPinAnnotationView *annotationView = (MKPinAnnotationView *)
  [mapView 
   dequeueReusableAnnotationViewWithIdentifier:
   pinReusableIdentifier];
  
  if (annotationView == nil){
    /* If we fail to reuse a pin, then we will create one */
    annotationView = 
    [[[MKPinAnnotationView alloc] 
      initWithAnnotation:senderAnnotation
      reuseIdentifier:pinReusableIdentifier] autorelease];
    
    /* Make sure we can see the callouts on top of
     each pin in case we have assigned title and/or
     subtitle to each pin */
    annotationView.canShowCallout = YES;
    
  }
  
  /* Now make sure, whether we have reused a pin or not, that
   the color of the pin matches the color of the annotation */
  annotationView.pinColor = senderAnnotation.pinColor;
  
  UIImage *pinImage = [UIImage imageNamed:@"BluePin.png"];
  if (pinImage != nil){
    annotationView.image = pinImage;
  }
  
  result = annotationView;
  
  return(result);
}

/* --------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
  
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CLLocationManager *newLocationManager = 
  [[CLLocationManager alloc] init];
  
  self.locationManager = newLocationManager;
  [newLocationManager release];
  
  self.locationManager.delegate = self;
  
  self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  self.locationManager.distanceFilter = 100;
  
  [self.locationManager startUpdatingLocation];
  
  
  /* Create a map as big as our view */
  MKMapView *mapView = [[MKMapView alloc] 
                        initWithFrame:self.view.bounds];
  self.myMapView = mapView;
  [mapView release];
  
  self.myMapView.delegate = self;
  
  /* Set the map type to Standard */
  self.myMapView.mapType = MKMapTypeStandard;
  
  self.myMapView.autoresizingMask = 
  UIViewAutoresizingFlexibleWidth |
  UIViewAutoresizingFlexibleHeight;
  
  /* Add it to our view */
  [self.view addSubview:self.myMapView];
  
  CLLocationCoordinate2D location;
  location.latitude = 40.82191692907181;
  location.longitude = -0.13811767101287842;
  MyAnnotation *annotation = 
    [[MyAnnotation alloc] 
      initWithCoordinates:location
      andTitle:@"My Title"
      andSubTitle:@"My Sub Title"];
  
  [self.myMapView addAnnotation:annotation];
  
  [annotation release];
  
  MKCoordinateRegion region;
  region.center = location;
  region.span.latitudeDelta = 0.001f;
  region.span.longitudeDelta = 0.001;
  [self.myMapView setRegion:region
                 animated:YES];
  
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.myMapView = nil;
  
  if (self.locationManager != nil){
    [self.locationManager stopUpdatingLocation];
  }
  
  self.locationManager = nil;
  
}

/* --------------------------------------------- */

- (void)dealloc {
  
  /* Deallocate the map */
  if (locationManager != nil){
    [locationManager stopUpdatingLocation];
  }
  [locationManager release];
  
  [myMapView release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
