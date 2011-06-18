//
//  RootViewController.h
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

/* ----------------------------------- */

@interface RootViewController : UIViewController {
@public
  CMMotionManager *motionManager;
  UIButton        *myButton;
}

/* ----------------------------------- */

@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) IBOutlet UIButton        *myButton;

/* ----------------------------------- */

@end
