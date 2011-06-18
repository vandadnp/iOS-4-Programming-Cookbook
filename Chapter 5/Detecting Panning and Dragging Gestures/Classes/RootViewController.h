//
//  RootViewController.h
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* --------------------------------------------- */

@interface RootViewController : UIViewController {
@public
  UIPanGestureRecognizer  *panGestureRecognizer;
  UILabel                 *helloWorldLabel;
}

/* --------------------------------------------- */

@property (nonatomic, retain) UIPanGestureRecognizer  *panGestureRecognizer;
@property (nonatomic, retain) UILabel        *helloWorldLabel;

/* --------------------------------------------- */

@end
