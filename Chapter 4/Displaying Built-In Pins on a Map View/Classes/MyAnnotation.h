//
//  MyAnnotation.h
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-10.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/* --------------------------------------------- */

@interface MyAnnotation : NSObject <MKAnnotation> {
@private
  CLLocationCoordinate2D coordinate;
  NSString *title;
  NSString *subtitle;
}

/* --------------------------------------------- */

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

/* --------------------------------------------- */

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates 
                     title:(NSString *)paramTitle 
                  subTitle:(NSString *)paramSubTitle;

/* --------------------------------------------- */

@end