//
//  Tray.h
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>



@class    Tray;



@protocol TrayProtocol <NSObject>
@required
  - (void) trayHasRunoutofPaper:(Tray *)paramSender;
@end



@interface Tray : NSObject {
@public
  id<TrayProtocol>          ownerDevice;
@private
  NSUInteger                paperCount;
}



@property (nonatomic, assign) id<TrayProtocol>  ownerDevice;
@property (nonatomic, assign) NSUInteger        paperCount;



- (BOOL)  givePapertoPrinter;
/* Designated Initializer */
- (id)    initWithOwnerDevice:(id<TrayProtocol>)paramOwnerDevice;



@end
