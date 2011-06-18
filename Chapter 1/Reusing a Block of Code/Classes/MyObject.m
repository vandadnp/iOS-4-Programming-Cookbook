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

@synthesize myValue;

- (NSNumber*) myMethodWithString:(NSString*)param1
                       andParam2:(NSInteger)param2{
  
  NSNumber *Result = [NSNumber numberWithInt:1];
  
  /* Do some computation here using the parameters
   and eventually return a value */
  
  return(Result);
  
}

/* --------------------------------------------- */

- (void) myMethod:(int)param1 andParam2:(int)param2{
  
  SEL thisMethod = @selector(myMethod:andParam2:);
  
  /* Use the ThisMethod selector here */
  
}

/* --------------------------------------------- */


//BOOL sendEmail(char *to, 
//               char *subject, 
//               char *emailMessage){
//  
//  BOOL Result = NO;
//  
//  return(Result);
//  
//}

/* --------------------------------------------- */

- (BOOL) sendEmailTo:(NSString*)paramTo 
         withSubject:(NSString*)paramSubject 
     andEmailMessage:(NSString*)paramEmailMessage{
  
  BOOL Result = NO;
  
  /* Send the email and return an appropriate value */
  
  return(Result);
  
}

/* --------------------------------------------- */

- (void) dealloc {
  
  [super dealloc];
  
}

/* --------------------------------------------- */

@end
