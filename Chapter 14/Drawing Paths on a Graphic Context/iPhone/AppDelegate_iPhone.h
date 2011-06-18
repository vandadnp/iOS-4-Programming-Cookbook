//
//  AppDelegate_iPhone.h
//  Graphics
//
//  Created by Vandad Nahavandipoor on 10-07-31.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* --------------------------------- */

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController  *navigationController;
}

/* --------------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UINavigationController  *navigationController;

/* --------------------------------- */

@end

