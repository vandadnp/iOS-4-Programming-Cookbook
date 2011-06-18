//
//  RootViewController.h
//  Contacts
//
//  Created by Vandad Nahavandipoor on 10-07-20.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

/* ------------------------------- */

@interface RootViewController : UIViewController {
@public
  UIImageView *imageViewOldImage;
  UIImageView *imageViewNewImage;
}

/* ------------------------------- */

@property (nonatomic, retain) 
IBOutlet UIImageView *imageViewOldImage;

@property (nonatomic, retain)
IBOutlet UIImageView *imageViewNewImage;

/* ------------------------------- */

@end