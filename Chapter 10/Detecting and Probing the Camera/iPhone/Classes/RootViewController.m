//
//  RootViewController.m
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ------------------------------- */

@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/* ------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

/* ------------------------------- */

- (BOOL)  isCameraAvailable{
  
  return([UIImagePickerController 
          isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]);
  
}

/* ------------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  if ([self isCameraAvailable] == YES){
//    NSLog(@"The camera is available.");
//  } else {
//    NSLog(@"The camera is not available.");
//  }
//}

/* ------------------------------- */

- (BOOL) doesCameraSupportMediaType:(NSString *)paramMediaType 
 onSourceType:(UIImagePickerControllerSourceType)paramSourceType{
  
  BOOL result = NO;
  
  if (paramMediaType == nil ||
      [paramMediaType length] == 0){
    return(NO);
  }
  
  if ([UIImagePickerController 
       isSourceTypeAvailable:paramSourceType] == NO){
    return(NO);
  }
  
  NSArray *mediaTypes = 
  [UIImagePickerController 
   availableMediaTypesForSourceType:paramSourceType];
  
  if (mediaTypes == nil){
    return(NO);
  }
  
  for (NSString *mediaType in mediaTypes){
    
    if ([mediaType isEqualToString:paramMediaType] == YES){
      return(YES);
    }
    
  }
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  doesCameraSupportShootingVideos{
  
  BOOL result = NO;
  
  result = 
  [self doesCameraSupportMediaType:(NSString *)kUTTypeMovie
        onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  doesCameraSupportTakingPhotos{
  
  BOOL result = NO;
  
  result = 
  [self doesCameraSupportMediaType:(NSString *)kUTTypeImage
        onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(result);
  
}

/* ------------------------------- */

/*- (void)viewDidLoad {
  [super viewDidLoad];
  
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
  
}*/

/* ------------------------------- */

- (BOOL)  isFrontCameraAvailable{
  
  BOOL result = NO;
  
  #ifdef __IPHONE_4_0
    #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
      result = [UIImagePickerController 
                isCameraDeviceAvailable:
                UIImagePickerControllerCameraDeviceFront];
    #endif
  #endif
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  isRearCameraAvailable{
  
  BOOL result = NO;
  
  #ifdef __IPHONE_4_0
    #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
      result = [UIImagePickerController 
                isCameraDeviceAvailable:
                UIImagePickerControllerCameraDeviceRear];
    #endif
  #endif
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  isFlashAvailableOnRearCamera{
  
  BOOL result = NO;
  
  #ifdef __IPHONE_4_0
    #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
      result = [UIImagePickerController 
                isFlashAvailableForCameraDevice:
                UIImagePickerControllerCameraDeviceRear];
    #endif
  #endif
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  isFlashAvailableOnFrontCamera{
  
  BOOL result = NO;
  
  #ifdef __IPHONE_4_0
    #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
      result = [UIImagePickerController 
                isFlashAvailableForCameraDevice:
                UIImagePickerControllerCameraDeviceFront];
    #endif
  #endif
  
  return(result);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
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

}


/* ------------------------------- */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}



- (void)dealloc {
  [super dealloc];
}


@end
