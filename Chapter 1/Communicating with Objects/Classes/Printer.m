//
//  Printer.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import "Printer.h"



@implementation Printer



@synthesize paperTray;



- (void) trayHasRunoutofPaper:(Tray *)Sender{
  NSLog(@"No papers in the paper tray. Please load more papers.");
}



- (void) print {
  
  /* Do the actual printing here after we have a sheet of paper */
    
}



- (BOOL) printPaperWithText:(NSString *)paramText 
             numberofCopies:(NSUInteger)paramNumberOfCopies{
  
  BOOL result = NO;
  
  if (paramNumberOfCopies > 0){
    
    NSUInteger copyCounter = 0;
    for (copyCounter = 0; 
         copyCounter < paramNumberOfCopies; 
         copyCounter++){
      /* First get a sheet of paper from the tray */
      if ([self.paperTray givePapertoPrinter] == YES){
        NSLog(@"Print Job #%lu", (unsigned long)copyCounter+1);
        [self print];
      } else {
        /* No more papers in the tray */
        return(NO);
      }
    }
    result = YES;
  } /* if (paramNumberOfCopies > 0){ */
  
  return(result);
  
}



- (id) init {
  self = [super init];
  
  if (self != nil){
    Tray *newTray = [[Tray alloc] initWithOwnerDevice:self];
    paperTray = [newTray retain];
    [newTray release];
  }
  
  return(self);
}



- (void) dealloc {
	NSLog(@"HERE");
  [paperTray release];
  [super dealloc];
  
}



@end
