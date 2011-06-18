//
//  MapsAppDelegate.h
//  Maps
//
//  Created by Vandad Nahavandipoor on 10-05-07.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class RootViewController;

@interface MapsAppDelegate : NSObject <UIApplicationDelegate> {
  
  UINavigationController      *NavigationController;
  UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

