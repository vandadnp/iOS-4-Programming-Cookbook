//
//  ViewsAndVCAppDelegate.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface ViewsAndVCAppDelegate : NSObject <UIApplicationDelegate> {
@public
  UIWindow *window;
  UINavigationController  *navigationController;
}

/* -------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UINavigationController  *navigationController;

/* -------------------------- */

@end

