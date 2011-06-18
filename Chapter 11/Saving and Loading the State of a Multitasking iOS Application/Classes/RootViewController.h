//
//  RootViewController.h
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ------------------------------------------- */

@interface RootViewController : UIViewController{
@private
  BOOL  isExecutingInBackground;
}

/* ------------------------------------------- */

@property (nonatomic, assign) BOOL  isExecutingInBackground;

/* ------------------------------------------- */

@end
