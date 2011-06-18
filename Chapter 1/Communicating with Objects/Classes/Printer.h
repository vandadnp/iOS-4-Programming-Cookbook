//
//  Printer.h
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tray.h"



@interface Printer : NSObject <TrayProtocol> {
@public
  Tray  *paperTray;
}



@property (nonatomic, retain) Tray  *paperTray;



- (BOOL) printPaperWithText:(NSString *)paramText 
             numberofCopies:(NSUInteger)paramNumberOfCopies;



@end