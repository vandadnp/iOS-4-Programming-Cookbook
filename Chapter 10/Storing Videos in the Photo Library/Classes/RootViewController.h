//
//  RootViewController.h
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

/* ------------------------------- */

@interface RootViewController : UIViewController {
@protected
  ALAssetsLibrary       *assetsLibrary;
}

/* ------------------------------- */

@property (nonatomic, retain) ALAssetsLibrary       *assetsLibrary;

/* ------------------------------- */

@end
