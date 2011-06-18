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

#define GOOGLE_OUTPUT_FORMAT_CSV  @"csv"
#define GOOGLE_OUTPUT_FORMAT_XML  @"xml"

/* --------------------------------------------- */

@interface RootViewController : UIViewController {
@public
  NSURLConnection *myConnection;
  NSMutableData   *connectionData;
}

/* --------------------------------------------- */

@property (nonatomic, retain) NSURLConnection *myConnection;
@property (nonatomic, retain) NSMutableData   *connectionData;

/* --------------------------------------------- */

@end
