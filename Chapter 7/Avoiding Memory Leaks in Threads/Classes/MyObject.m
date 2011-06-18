//
//  MyObject.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-08-18.
//  Copyright 2010  All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

/* -------------------------- */

- (void) doSomething{
  /* Empty implementation */
}

/* -------------------------- */

- (id) init {
  self = [super init];
  
  if (self != nil){
    NSLog(@"Initialized");
  }
  
  return(self);
}

/* -------------------------- */

- (void) dealloc {
  
  NSLog(@"Deallocated");
  [super dealloc];
}

/* -------------------------- */

@end
