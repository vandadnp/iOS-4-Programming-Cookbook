//
//  OperationsAppDelegate.h
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface OperationsAppDelegate : NSObject 
           <UIApplicationDelegate> {
  
  UIWindow *window;
  NSBlockOperation   *simpleOperation;
  
}

/* -------------------------- */

@property (nonatomic, retain)
IBOutlet UIWindow *window;

@property (nonatomic, retain) 
NSBlockOperation   *simpleOperation;

/* -------------------------- */

@end