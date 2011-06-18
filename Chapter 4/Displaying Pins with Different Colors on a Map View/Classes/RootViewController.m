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
   identifier for the pin we are about
   to create */
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
    [annotationView setCanShowCallout:YES];
  }
  
  /* Now make sure, whether we have reused a pin or not, that
   the color of the pin matches the color of the annotation */
  annotationView.pinColor = senderAnnotation.pinColor;
  
  result = annotationView;
  
  return(result);
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
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
  
  /* This is just a sample location */
  CLLocationCoordinate2D location;
  location.latitude = 50.82191692907181;
  location.longitude = -0.13811767101287842;
  
  /* Create the annotation using the location */
  MyAnnotation *annotation = 
  [[MyAnnotation alloc] initWithCoordinates:location
                                      title:@"My Title"
                                   subTitle:@"My Sub Title"];
  
  annotation.pinColor = MKPinAnnotationColorPurple;
  
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

- (void) didReceiveMemoryWarning{
  [super didReceiveMemoryWarning];
}

/* --------------------------------------------- */

- (void)dealloc {
  /* Deallocate the map */
  [myMapView release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
