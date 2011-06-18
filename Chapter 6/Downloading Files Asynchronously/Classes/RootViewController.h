//
//  RootViewController.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

// http://support.apple.com/downloads/DL851/en_US/iPhoneConfigurationUtility.dmg

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface RootViewController : UIViewController{
@public
  NSURLConnection       *connection;
  NSMutableData         *connectionData;
}

/* -------------------------- */

@property (nonatomic, retain) NSURLConnection       *connection;
@property (nonatomic, retain) NSMutableData         *connectionData;

/* -------------------------- */

@end