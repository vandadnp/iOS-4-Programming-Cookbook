//
//  SwipesAppDelegate.h
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipesAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow      *window;
  UINavigationController    *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UINavigationController    *navigationController;

@end

