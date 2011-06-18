//
//  AppDelegate_iPhone.h
//  Test
//
//  Created by Vandad Nahavandipoor on 10-07-28.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ----------------------------------- */

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController  *navigationController;
}

/* ----------------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController  *navigationController;

/* ----------------------------------- */

@end

