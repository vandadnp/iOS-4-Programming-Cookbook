//
//  ThreadsAppDelegate.h
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-06-29.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

/* -------------------------- */

@interface ThreadsAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow          *window;
  NSTimer           *paintingTimer;
}

/* -------------------------- */

@property (nonatomic, retain) NSTimer           *paintingTimer;
@property (nonatomic, retain) IBOutlet UIWindow *window;

/* -------------------------- */

@end

