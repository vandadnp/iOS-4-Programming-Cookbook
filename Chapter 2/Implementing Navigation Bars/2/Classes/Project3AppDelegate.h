//
//  Project3AppDelegate.h
//  Project3
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@class Project3ViewController;

/* -------------------------- */

@interface Project3AppDelegate : NSObject
           <UIApplicationDelegate> {
@public
  UIWindow                *window;
  Project3ViewController  *viewController;
  UINavigationController  *navigationController;
}

/* -------------------------- */

@property (nonatomic, retain) 
IBOutlet UIWindow *window;

@property (nonatomic, retain) 
IBOutlet Project3ViewController *viewController;

@property (nonatomic, retain) 
UINavigationController  *navigationController;

/* -------------------------- */

@end