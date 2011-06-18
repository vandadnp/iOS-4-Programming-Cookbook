//
//  RootViewController.h
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

/* ------------------------------- */

@interface RootViewController : UIViewController 
                                <UINavigationControllerDelegate, 
                                UIImagePickerControllerDelegate, 
                                UIVideoEditorControllerDelegate> {
@public
  NSURL *videoURLToEdit;
}

/* ------------------------------- */

@property (nonatomic, retain) NSURL *videoURLToEdit;

/* ------------------------------- */

@end
