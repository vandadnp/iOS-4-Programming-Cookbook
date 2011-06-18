//
//  TablesAppDelegate.h
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TablesAppDelegate : NSObject <UIApplicationDelegate> {
@public
  UIWindow *window;
  UINavigationController  *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UINavigationController  *navigationController;

@end

