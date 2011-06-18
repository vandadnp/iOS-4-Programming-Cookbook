//
//  MyObject.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

/* --------------------------------------------- */

@synthesize stringValue;
@synthesize integerValue;

/* --------------------------------------------- */

- (id) init {
  self = [super init];
  
  if (self != nil){
    stringValue = [@"Some Value" copy];
    integerValue = 123;
  }
  
  return(self);
}

/* --------------------------------------------- */

- (void) dealloc{
  [stringValue release];
  [super dealloc];
}

/* --------------------------------------------- */

@end