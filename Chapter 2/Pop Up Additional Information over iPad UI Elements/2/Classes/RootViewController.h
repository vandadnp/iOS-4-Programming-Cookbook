//
//  RootViewController.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-10-15.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* --------------------- */

@interface RootViewController : UIViewController{
@protected
  UIBarButtonItem     *barButtonAdd;
  UIPopoverController *popoverController;
}

/* --------------------- */

@property (nonatomic, retain) 
UIBarButtonItem   *barButtonAdd;

@property (nonatomic, retain) 
UIPopoverController *popoverController;

/* --------------------- */

@end
