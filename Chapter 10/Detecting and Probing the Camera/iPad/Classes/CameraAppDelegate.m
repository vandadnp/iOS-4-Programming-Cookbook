//
//  CameraAppDelegate.m
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import "CameraAppDelegate.h"

@implementation CameraAppDelegate

@synthesize window;

- (BOOL) doesCameraSupportMediaType:(NSString *)paramMediaType 
                       onSourceType:(UIImagePickerControllerSourceType)paramSourceType{
  
  BOOL Result = NO;
  
  if (paramMediaType == nil ||
      [paramMediaType length] == 0){
    return(NO);
  }
  
  if ([UIImagePickerController isSourceTypeAvailable:paramSourceType] == NO){
    return(NO);
  }
  
  NSArray *MediaTypes = [UIImagePickerController 
                         availableMediaTypesForSourceType:paramSourceType];
  
  if (MediaTypes == nil){
    return(NO);
  }
  
  for (NSString *MediaType in MediaTypes){
    
    if ([MediaType isEqualToString:paramMediaType] == YES){
      return(YES);
    }
    
  }
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  doesCameraSupportShootingVideos{
  
  BOOL Result = NO;
  
  Result = [self doesCameraSupportMediaType:(NSString *)kUTTypeMovie
                               onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  doesCameraSupportTakingPhotos{
  
  BOOL Result = NO;
  
  Result = [self doesCameraSupportMediaType:(NSString *)kUTTypeImage
                               onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  isFrontCameraAvailable{
  
  BOOL Result = NO;
  
#ifdef __IPHONE_4_0
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
  Result = [UIImagePickerController 
            isCameraDeviceAvailable:
            UIImagePickerControllerCameraDeviceFront];
#endif
#endif
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  isRearCameraAvailable{
  
  BOOL Result = NO;
  
#ifdef __IPHONE_4_0
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
  Result = [UIImagePickerController 
            isCameraDeviceAvailable:
            UIImagePickerControllerCameraDeviceRear];
#endif
#endif
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  isFlashAvailableOnRearCamera{
  
  BOOL Result = FALSE;
  
#ifdef __IPHONE_4_0
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
  Result = [UIImagePickerController 
            isFlashAvailableForCameraDevice:
            UIImagePickerControllerCameraDeviceRear];
#endif
#endif
  
  return(Result);
  
}

/* ------------------------------- */

- (BOOL)  isFlashAvailableOnFrontCamera{
  
  BOOL Result = FALSE;
  
#ifdef __IPHONE_4_0
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
  Result = [UIImagePickerController 
            isFlashAvailableForCameraDevice:
            UIImagePickerControllerCameraDeviceFront];
#endif
#endif
  
  return(Result);
  
}

/* ------------------------------- */

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

  if ([self isFrontCameraAvailable] == YES){
    NSLog(@"The front camera is available.");
    if ([self isFlashAvailableOnFrontCamera] == YES){
      NSLog(@"The front camera is equipped with a flash");
    } else {
      NSLog(@"The front camera is not equipped with a flash");
    }
  } else {
    NSLog(@"The front camera is not available.");
  }
  
  if ([self isRearCameraAvailable] == YES){
    NSLog(@"The rear camera is available.");
    if ([self isFlashAvailableOnRearCamera] == YES){
      NSLog(@"The rear camera is equipped with a flash");
    } else {
      NSLog(@"The rear camera is not equipped with a flash");
    }
  } else {
    NSLog(@"The rear camera is not available.");
  }
  
  if ([self doesCameraSupportTakingPhotos] == YES){
    NSLog(@"The camera supports taking photos.");
  } else {
    NSLog(@"The camera does not support taking photos");
  }
  
  if ([self doesCameraSupportShootingVideos] == YES){
    NSLog(@"The camera supports shooting videos.");
  } else {
    NSLog(@"The camera does not support shooting videos.");
  }
  
  [window makeKeyAndVisible];
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  [window release];
  [super dealloc];
}


@end
