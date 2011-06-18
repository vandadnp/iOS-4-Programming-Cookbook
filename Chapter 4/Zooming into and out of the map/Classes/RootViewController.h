//
//  RootViewController.h
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

/* --------------------------------------------- */

@interface RootViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
@public
  MKMapView         *MapView;
  CLLocationManager *LocationManager;
}

/* --------------------------------------------- */

@property (nonatomic, assign) MKMapView   *MapView;
@property (nonatomic, assign) CLLocationManager *LocationManager;

/* --------------------------------------------- */

@end
