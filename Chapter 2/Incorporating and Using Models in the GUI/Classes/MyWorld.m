//
//  MyWorld.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright 2010  All rights reserved.
//

#import "MyWorld.h"

/* -------------------------- */

@implementation MyWorld

/* -------------------------- */

static MyWorld      *sharedInstance = nil;

/* -------------------------- */

- (id) init {
  
  self = [super init];
  
  if (self != nil){
    
    /* Do NOT allocate/initialize other objects here
     that might use the MyWorld's sharedInstance as
     that will create an infinite loop */
    
  }
  
  return(self);
  
}

/* -------------------------- */

- (void) initializeSharedInstance{
  
  /* Allocate/initialize your values here as we are
   sure this method gets called only AFTER the 
   instance of MyWorld has been created through
   the [sharedInstance] class method */
  
}

/* -------------------------- */

+ (MyWorld *)     sharedInstance{
  @synchronized(self){
    if (sharedInstance == nil){
      sharedInstance = [[self alloc] init];
      /* Now initialize the shared instance */
      [sharedInstance initializeSharedInstance];
    }
    return(sharedInstance);
  }
  
}

/* -------------------------- */

- (NSUInteger) retainCount{
  return(NSUIntegerMax);
}

/* -------------------------- */

- (void) release{
  /* Don't call super here. The shared instance should
   not be deallocated */
}

/* -------------------------- */

- (id) autorelease{
  return(self);
}

/* -------------------------- */

- (id) retain{
  return(self);
}

/* -------------------------- */

- (void) dealloc {
  [super dealloc];
}

/* -------------------------- */

@end
