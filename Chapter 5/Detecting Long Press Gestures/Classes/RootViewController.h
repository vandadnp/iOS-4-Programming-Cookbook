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
  UILongPressGestureRecognizer  *longPressGestureRecognizer;
  UIButton                      *dummyButton;
}

/* -------------------------- */

@property (nonatomic, retain) 
  UILongPressGestureRecognizer  *longPressGestureRecognizer;

@property (nonatomic, retain) IBOutlet UIButton *dummyButton;

/* -------------------------- */

@end
