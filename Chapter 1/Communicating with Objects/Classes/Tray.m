//
//  Tray.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import "Tray.h"



@implementation Tray



@synthesize paperCount;
@synthesize ownerDevice;



- (id) init {
  /* Call the designated initializer */
  return([self initWithOwnerDevice:nil]);
  
}



- (id) initWithOwnerDevice:(id<TrayProtocol>)paramOwnerDevice {
  
  self = [super init];
  
  if (self != nil){
	  ownerDevice = paramOwnerDevice;
    /* Initially we have only 10 papers */
    paperCount = 10;
  }
  
  return(self);
}



- (BOOL) givePapertoPrinter{
  
  BOOL result = NO;
  
  if (self.paperCount > 0){
    /* We have some papers left */
    result = YES;
    self.paperCount--;
  } else {
    /* We have run out of papers */
    [self.ownerDevice trayHasRunoutofPaper:self];
  }
  
  return(result);
  
}



- (void) dealloc {
  [super dealloc];
}



@end