//
//  OperationsAppDelegate.h
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleOperation;

/* -------------------------- */

@interface OperationsAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  NSOperationQueue  *operationQueue;
  SimpleOperation   *firstOperation;
  SimpleOperation   *secondOperation;
  
}

/* -------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSOperationQueue  *operationQueue;
@property (nonatomic, retain) SimpleOperation   *firstOperation;
@property (nonatomic, retain) SimpleOperation   *secondOperation;

/* -------------------------- */

@end

