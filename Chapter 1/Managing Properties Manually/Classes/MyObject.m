//
//  MyObject.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import "MyObject.h"

/* --------------------------------------------- */

@implementation MyObject

/* --------------------------------------------- */

@synthesize addressLine;

/* --------------------------------------------- */

- (void) setAddressLine:(NSString *)paramValue{
  
  if ([paramValue length] > 20){
    return;
  }
  
  if (paramValue != addressLine){
    [addressLine release];
    addressLine = [paramValue copy];
  }
    
}

/* --------------------------------------------- */

- (void) dealloc {
  [addressLine release];
  [super dealloc];
}

/* --------------------------------------------- */

@end