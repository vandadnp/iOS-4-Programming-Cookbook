//
//  AppDelegate_iPhone.h
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-24.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"

/* ------------------------------------------- */

@interface AppDelegate_iPhone : AppDelegate_Shared {
@public
  UINavigationController  *navigationController;
}

/* ------------------------------------------- */

@property (nonatomic, retain) 
UINavigationController  *navigationController;

/* ------------------------------------------- */

@end

