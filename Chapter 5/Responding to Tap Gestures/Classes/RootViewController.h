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
  UITapGestureRecognizer  *tapGestureRecognizer;
}

/* -------------------------- */

@property (nonatomic, retain) 
UITapGestureRecognizer  *tapGestureRecognizer;

/* -------------------------- */

@end