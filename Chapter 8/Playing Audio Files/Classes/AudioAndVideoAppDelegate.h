//
//  AudioAndVideoAppDelegate.h
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioAndVideoViewController;

@interface AudioAndVideoAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController  *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UINavigationController  *navigationController;

@end

