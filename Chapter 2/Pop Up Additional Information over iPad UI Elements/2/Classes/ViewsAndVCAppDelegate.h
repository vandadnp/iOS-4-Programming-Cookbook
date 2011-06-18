//
//  ViewsAndVCAppDelegate.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-10-15.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* --------------------- */

@interface ViewsAndVCAppDelegate : NSObject 
           <UIApplicationDelegate> {
@protected
  UIWindow *window;
  UINavigationController  *navigationController;
}

/* --------------------- */

@property (nonatomic, retain) 
IBOutlet UIWindow *window;

@property (nonatomic, retain) 
UINavigationController  *navigationController;

/* --------------------- */

@end

