//
//  MyAnnotation.m
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-10.
//  Copyright 2010  All rights reserved.
//

#import "MyAnnotation.h"

/* --------------------------------------------- */

@implementation MyAnnotation

/* --------------------------------------------- */

@synthesize coordinate, title, subtitle, PinColor;

/* --------------------------------------------- */

+ (NSString*)   PinReusableIdentifierforPinColor
                :(MKPinAnnotationColor)ParamColor{
  
  NSString *Result = nil;
  
  switch (ParamColor){
    case MKPinAnnotationColorRed:{
      Result = REUSABLE_PIN_RED;
      break;
    }
    case MKPinAnnotationColorGreen:{
      Result = REUSABLE_PIN_GREEN;
      break;
    }
    case MKPinAnnotationColorPurple:{
      Result = REUSABLE_PIN_PURPLE;
      break;
    }
  }
  
  return(Result);
}

/* --------------------------------------------- */

- (id) initWithCoordinates:(CLLocationCoordinate2D)ParamCoordinates 
                  AndTitle:(NSString*)ParamTitle 
               AndSubTitle:(NSString*)ParamSubTitle{
  self = [super init];
  
  if (self != nil){
    coordinate = ParamCoordinates;
    self.title = ParamTitle;
    self.subtitle = ParamSubTitle;
    self.PinColor = MKPinAnnotationColorGreen;
  }
  
  return(self);
}

/* --------------------------------------------- */

- (void) dealloc {
  
  if (self.title != nil){
    [self.title release];
  }
  
  if (self.subtitle != nil){
    [self.subtitle release];
  }
  
  [super dealloc];
}

/* --------------------------------------------- */

@end
