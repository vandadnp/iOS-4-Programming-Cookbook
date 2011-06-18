//
//  RootViewController.h
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-07-04.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface RootViewController : UIViewController {
@public
  NSThread        *myThread;
  NSTimer         *myTimer;
}

/* -------------------------- */

@property (nonatomic, retain) NSThread        *myThread;
@property (nonatomic, retain) NSTimer         *myTimer;

/* -------------------------- */

@end
