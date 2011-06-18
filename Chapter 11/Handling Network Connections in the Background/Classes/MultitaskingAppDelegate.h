//
//  MultitaskingAppDelegate.h
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

//http://appldnld.apple.com.edgesuite.net/content.info.apple.com/iPhone4/061-7380.20100621,Vfgb5/iPhone3,1_4.0_8A293_Restore.ipsw
//http://support.apple.com/downloads/DL851/en_US/iPhoneConfigurationUtility.dmg

#import <UIKit/UIKit.h>

/* ------------------------------------------- */

@interface MultitaskingAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow          *window;
  NSURLConnection   *downloadConnection;
  NSInteger         connectionDataLength;
}

/* ------------------------------------------- */

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSURLConnection   *downloadConnection;
@property (nonatomic, assign) NSInteger         connectionDataLength;

/* ------------------------------------------- */

@end