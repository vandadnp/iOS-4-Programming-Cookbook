//
//  RootViewController.h
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface RootViewController : UIViewController {
@public
  UIPinchGestureRecognizer  *pinchGestureRecognizer;
  UILabel *myBlackLabel;
  CGFloat currentScale;
}

/* -------------------------- */

@property (nonatomic, retain) 
UIPinchGestureRecognizer  *pinchGestureRecognizer;

@property (nonatomic, retain) UILabel *myBlackLabel;
@property (nonatomic, assign) CGFloat currentScale;

/* -------------------------- */

@end
