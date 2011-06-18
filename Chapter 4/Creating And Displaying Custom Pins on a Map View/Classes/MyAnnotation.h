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
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, assign) MKPinAnnotationColor  pinColor;

/* --------------------------------------------- */

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates 
                  andTitle:(NSString*)paramTitle 
               andSubTitle:(NSString*)paramSubTitle;

+ (NSString *)   reusableIdentifierforPinColor
                 :(MKPinAnnotationColor)ParamColor;

/* --------------------------------------------- */

@end
