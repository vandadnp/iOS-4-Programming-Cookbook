//
//  ViewsAndVCAppDelegate.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewsAndVCViewController;

@interface ViewsAndVCAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewsAndVCViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewsAndVCViewController *viewController;

@end

