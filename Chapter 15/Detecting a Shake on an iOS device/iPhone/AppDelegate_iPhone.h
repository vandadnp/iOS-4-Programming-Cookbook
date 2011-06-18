//
//  AppDelegate_iPhone.h
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainWindow;

/* ----------------------------------- */

@interface AppDelegate_iPhone : NSObject 
           <UIApplicationDelegate> {
  
  MainWindow *window;
  UINavigationController  *navigationController;
  
}

/* ----------------------------------- */

@property (nonatomic, retain) 
IBOutlet MainWindow *window;

@property (nonatomic, retain) 
UINavigationController  *navigationController;

/* ----------------------------------- */

@end

