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
           <UIApplicationDelegate> {
  UIWindow                      *window;
  UISplitViewController         *splitViewController;
}

/* -------------------------- */

@property (nonatomic, retain) 
IBOutlet UIWindow *window;

@property (nonatomic, retain) 
UISplitViewController *splitViewController;

/* -------------------------- */

@end