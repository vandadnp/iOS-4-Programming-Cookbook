//
//  ViewsAndVCAppDelegate.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface ViewsAndVCAppDelegate : NSObject 
           <UIApplicationDelegate, UISplitViewControllerDelegate> {
             
  UIWindow                      *window;
  UISplitViewController         *splitViewController;
  UIViewController              *rightViewController;
  UIViewController              *leftViewController;
}

/* -------------------------- */

@property (nonatomic, retain) 
IBOutlet UIWindow *window;

@property (nonatomic, retain) 
UISplitViewController *splitViewController;

@property (nonatomic, retain) 
UIViewController      *rightViewController;

@property (nonatomic, retain) 
UIViewController      *leftViewController;

/* -------------------------- */

@end