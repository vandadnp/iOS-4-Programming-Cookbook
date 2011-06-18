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
    NSMutableArray *childrenArray = 
    [[NSMutableArray alloc] init];
    
    children = [childrenArray mutableCopy];
    [childrenArray release];
    
    NSMutableDictionary *newAttributes = 
    [[NSMutableDictionary alloc] init];
    
    attributes = [newAttributes mutableCopy];
    [newAttributes release];
  }
  
  return(self);
}

/* -------------------------- */

- (void) dealloc {
  
  NSLog(@"Deallocated Element");
  
  [name release];
  [text release];
  [children release];
  [attributes release];
    
  [super dealloc];
}

/* -------------------------- */

@end
