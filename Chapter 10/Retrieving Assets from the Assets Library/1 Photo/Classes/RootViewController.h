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

#define NOTIFICATION_ASSET_IMAGE_RETRIEVED @"ASSET_IMG_RETRIEVED"

/* ------------------------------- */

@interface RootViewController : UIViewController {
@protected
  ALAssetsLibrary *assetsLibrary;
  UIImageView     *imageView;
}

/* ------------------------------- */

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) UIImageView     *imageView;

/* ------------------------------- */

@end
