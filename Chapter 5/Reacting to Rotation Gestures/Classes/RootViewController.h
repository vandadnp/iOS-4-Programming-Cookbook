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
@protected
  UILabel                     *helloWorldLabel;
  UIRotationGestureRecognizer *rotationGestureRecognizer;
  CGFloat                     rotationAngleInRadians;
}

/* -------------------------- */

@property (retain) UIRotationGestureRecognizer  *rotationGestureRecognizer;
@property (retain) IBOutlet UILabel             *helloWorldLabel;
@property (assign) CGFloat                      rotationAngleInRadians;

/* -------------------------- */

@end
