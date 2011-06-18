//
//  MainWindow.m
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow

/* ----------------------------------- */

- (void) motionEnded:(UIEventSubtype)motion 
           withEvent:(UIEvent *)event{
  
  if (motion == UIEventSubtypeMotionShake){
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NOTIFICATION_SHAKE
     object:event];
  }
  
}

/* ----------------------------------- */

@end
