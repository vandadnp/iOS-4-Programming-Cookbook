//
//  CountingOperation.m
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import "SimpleOperation.h"

/* -------------------------- */

@implementation SimpleOperation

/* -------------------------- */

- (id) init {
  NSNumber *dummyObject = [NSNumber numberWithInteger:123];
  return([self initWithObject:dummyObject]);
}

/* -------------------------- */

- (id) initWithObject:(NSObject *)paramObject{
  
  self = [super init];
  
  if (self != nil){
    
    if (paramObject == nil){
      /* The given data is not valid so fail
       the initialization */
      [self release];
      return(nil);
    }
    
    /* Keep these values for the main method */
    givenObject = [paramObject retain];
    
  }
  
  return(self);
  
}

/* -------------------------- */

- (void) start {
  
  /* If we are cancelled before starting, then
   we have to return immediately and generate the
   required KVO notifications */
  if ([self isCancelled] == YES){
    /* If this operation *is* cancelled */
    /* KVO compliance */
    [self willChangeValueForKey:@"isFinished"];
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    return;
    
  } else {
    /* If this operation is *not* cancelled */
    /* KVO compliance */
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    /* Call the main method from inside the start method */
    [self main];
    [self didChangeValueForKey:@"isExecuting"];
    
  }
  
}

/* -------------------------- */

- (void) main {
  
  @try {
    
    /* Here is our autorelease pool */
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    /* Keep a local variable here that must get set to YES
     whenever we are done with the task */
    BOOL taskIsFinished = NO;
    
    /* Create a while loop here that only exists
     if the taskIsFinished variable is set to YES or
     the operation has been cancelled */
    while (taskIsFinished == NO &&
           [self isCancelled] == NO){
      
      /* Perform the task here */
      NSLog(@"%s", __FUNCTION__);
      NSLog(@"Parameter Object = %@", givenObject);
      NSLog(@"Main Thread = %@", [NSThread mainThread]);
      NSLog(@"Current Thread = %@", [NSThread currentThread]);
      
      /* Very important. This way we can get out of the
       loop and we are still complying with the cancellation
       rules of operations */
      taskIsFinished = YES;
      
    }
    
    /* KVO compliance. Generate the 
     required KVO notifications */
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    finished = YES;
    executing = NO;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
    
    /* Make sure we are releasing the autorelease pool */
    [pool release];
    
  }
  @catch (NSException * e) {
    NSLog(@"Exception %@", e);
  }
  
}

/* -------------------------- */

- (BOOL)  isConcurrent{
  return(YES);
}

/* -------------------------- */

- (BOOL)  isFinished{
  /* Simply return the value */
  return(finished);
}

/* -------------------------- */

- (BOOL)  isExecuting{
  /* Simply return the value */
  return(executing);
}

/* -------------------------- */

@end