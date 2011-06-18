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

@interface RootViewController : UIViewController 
                                <MKMapViewDelegate, 
                                CLLocationManagerDelegate> {
@public
  MKMapView         *myMapView;
  CLLocationManager *locationManager;
}

/* --------------------------------------------- */

@property (nonatomic, retain) MKMapView   *myMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

/* --------------------------------------------- */

@end
