//
//  TablesAppDelegate.h
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface TablesAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

