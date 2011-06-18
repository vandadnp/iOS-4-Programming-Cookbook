//
//  RootViewController.h
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-08.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/* --------------------------------------------- */

@interface RootViewController : UIViewController <MKReverseGeocoderDelegate> {
@public
  MKReverseGeocoder *myReverseGeocoder;
}

/* --------------------------------------------- */

@property (nonatomic, retain) MKReverseGeocoder *myReverseGeocoder;

/* --------------------------------------------- */

@end
