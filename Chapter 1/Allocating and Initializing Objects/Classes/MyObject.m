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

@synthesize myInteger;

/* --------------------------------------------- */

- (void) doSomething{
  
  /* Perform a task here */
  NSLog(@"%s", __FUNCTION__);
  
  NSLog(@"%d", self.myInteger);
  
}

/* --------------------------------------------- */

@end
