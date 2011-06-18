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
  CLLocationCoordinate2D coordinate;
  NSString *title;
  NSString *subtitle;
  MKPinAnnotationColor  PinColor;
}

/* --------------------------------------------- */

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, assign) MKPinAnnotationColor  PinColor;

/* --------------------------------------------- */

- (id) initWithCoordinates:(CLLocationCoordinate2D)ParamCoordinates 
                  AndTitle:(NSString*)ParamTitle 
               AndSubTitle:(NSString*)ParamSubTitle;

+ (NSString*)   PinReusableIdentifierforPinColor
                :(MKPinAnnotationColor)ParamColor;

/* --------------------------------------------- */

@end
