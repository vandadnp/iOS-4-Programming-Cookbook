//
//  OperationsAppDelegate.h
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface OperationsAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  NSOperationQueue        *operationQueue;
  NSInvocationOperation   *firstOperation;
  NSInvocationOperation   *secondOperation;
  
}

/* -------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSOperationQueue      *operationQueue;
@property (nonatomic, retain) NSInvocationOperation *firstOperation;
@property (nonatomic, retain) NSInvocationOperation *secondOperation;

/* -------------------------- */

@end

