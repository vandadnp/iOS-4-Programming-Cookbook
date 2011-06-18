//
//  XMLElement.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import "XMLElement.h"

/* -------------------------- */

@implementation XMLElement

/* -------------------------- */

@synthesize name;
@synthesize text;
@synthesize parent;
@synthesize children;
@synthesize attributes;

/* -------------------------- */

- (id) init {
  self = [super init];
  
  if (self != nil){
    self.children = [[NSMutableArray alloc] init];
    self.attributes = [[NSMutableDictionary alloc] init];
  }
  
  return(self);
}

/* -------------------------- */

- (void) dealloc {
  
  if (self.text != nil){
    [self.text release];
  }
  
  if (self.name != nil){
    [self.name release];
  }
  
  if (self.children != nil){
    [self.children removeAllObjects];
    [self.children release];
  }
  
  if (self.attributes != nil){
    [self.attributes removeAllObjects];
    [self.attributes release];
  }
  
  [super dealloc];
}

/* -------------------------- */

@end
