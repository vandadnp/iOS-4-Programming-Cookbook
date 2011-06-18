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

@synthesize MapView, LocationManager;

/* --------------------------------------------- */

- (MKAnnotationView *)mapView:(MKMapView *)mapView 
            viewForAnnotation:(id <MKAnnotation>)annotation{
  
  MKAnnotationView *Result = nil;
  
  if ([annotation isKindOfClass:[MyAnnotation class]] == FALSE){
    return(Result);
  }
  
  if ([mapView isEqual:self.MapView] == FALSE){
    /* We want to process this event only for the Map View
     that we have created previously */
    return(Result);
  }
  
  /* First typecast the annotation for which the Map View has
   fired this delegate message */
  MyAnnotation *SenderAnnotation = (MyAnnotation*)annotation;

  /* Using the class method we have defined in our custom annotation class,
   we will attempt to get a reusable identifier for the pin we are about
   to create */
  NSString *PinReusableIdentifier = 
    [MyAnnotation PinReusableIdentifierforPinColor:SenderAnnotation.PinColor];
  
  /* Using the identifier we retrieved above, we will attempt to reuse a
   pin in the sender Map View */
  MKPinAnnotationView *AnnotationView = (MKPinAnnotationView*)
    [mapView dequeueReusableAnnotationViewWithIdentifier:PinReusableIdentifier];
  
  if (AnnotationView == nil){
    /* If we fail to reuse a pin, then we will create one */
    AnnotationView = 
      [[MKPinAnnotationView alloc] initWithAnnotation:SenderAnnotation
                                      reuseIdentifier:PinReusableIdentifier];
    
    /* Make sure we can see the callouts on top of
     each pin in case we have assigned title and/or subtitle to each pin */
    [AnnotationView setCanShowCallout:TRUE];
  
  }

  /* Now make sure, whether we have reused a pin or not, that
   the color of the pin matches the color of the annotation */
  AnnotationView.pinColor = SenderAnnotation.PinColor;
  
  UIImage *PinImage = [UIImage imageNamed:@"BluePin.png"];
  if (PinImage != nil){
    AnnotationView.image = PinImage;
  }
  
  Result = AnnotationView;
  
  return(Result);
}

/* --------------------------------------------- */

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
  

}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.LocationManager = [[CLLocationManager alloc] init];
  self.LocationManager.delegate = self;
  
  self.LocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  self.LocationManager.distanceFilter = 100;
  
  [self.LocationManager startUpdatingLocation];

    
  /* Create a map as big as our view */
  self.MapView = 
    [[MKMapView alloc] initWithFrame:self.view.frame];
  
  self.MapView.delegate = self;

  /* Set the map type to Satellite */
  [self.MapView setMapType:MKMapTypeStandard];
  
  /* Add it to our view */
  [self.view addSubview:self.MapView];
  
  CLLocationCoordinate2D Location;
  Location.latitude = 40.82191692907181;
  Location.longitude = -0.13811767101287842;
  MyAnnotation *Annotation = 
    [[MyAnnotation alloc] initWithCoordinates:Location
                                     AndTitle:@"My Title"
                                  AndSubTitle:@"My Sub Title"];
  [self.MapView addAnnotation:Annotation];
  
    
  MKCoordinateRegion Region;
  Region.center = Location;
  Region.span.latitudeDelta = 0.0f;
  Region.span.longitudeDelta = 0.0;
  [self.MapView setRegion:Region
                 animated:TRUE];
  
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  /* Support all orientations */
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  
  /* Deallocate the map */
  if (self.MapView != nil){
    if (self.MapView.superview != nil){
      [self.MapView removeFromSuperview];
    }
    [self.MapView release];
    self.MapView = nil;
  }
  
  [super dealloc];
}

/* --------------------------------------------- */

@end
