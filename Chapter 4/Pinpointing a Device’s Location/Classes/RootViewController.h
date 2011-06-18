//
//  RootViewController.h
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/* --------------------------------------------- */

@interface RootViewController : UIViewController 
                                <CLLocationManagerDelegate>{
@public
  CLLocationManager   *locationManager;
}

/* --------------------------------------------- */

@property (nonatomic, retain) CLLocationManager *locationManager;

/* --------------------------------------------- */

@end
