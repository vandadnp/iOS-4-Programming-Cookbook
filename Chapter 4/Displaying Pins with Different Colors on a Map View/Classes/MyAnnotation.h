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

/* These are the standard SDK pin colors. We are setting
 unique identifiers per color for each pin so that later we
 can reuse the pins that have already been created with the same
 color */

#define REUSABLE_PIN_RED    @"Red"
#define REUSABLE_PIN_GREEN  @"Green"
#define REUSABLE_PIN_PURPLE @"Purple"

/* --------------------------------------------- */

@interface MyAnnotation : NSObject <MKAnnotation> {
@private
  CLLocationCoordinate2D  coordinate;
  NSString                *title;
  NSString                *subtitle;
  MKPinAnnotationColor    pinColor;
}

/* --------------------------------------------- */

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *subtitle;
@property (nonatomic, assign) MKPinAnnotationColor  pinColor;

/* --------------------------------------------- */

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates 
                     title:(NSString*)paramTitle 
                  subTitle:(NSString*)paramSubTitle;

+ (NSString *)   reusableIdentifierforPinColor
                 :(MKPinAnnotationColor)paramColor;

/* --------------------------------------------- */

@end
