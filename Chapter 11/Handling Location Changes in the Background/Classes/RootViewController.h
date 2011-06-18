//
//  RootViewController.h
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/* ------------------------------------------- */

@interface RootViewController : UIViewController 
                                <CLLocationManagerDelegate> {
@public
  CLLocationManager     *myLocationManager;
@private
  BOOL                  isExecutingInBackground;
}

/* ------------------------------------------- */

@property (nonatomic, retain) 
CLLocationManager     *myLocationManager;

@property (nonatomic, assign) 
BOOL                  isExecutingInBackground;

/* ------------------------------------------- */

@end
