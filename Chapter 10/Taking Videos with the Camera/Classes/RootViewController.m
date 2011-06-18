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

/* ------------------------------- */

- (BOOL) doesCameraSupportMediaType:(NSString *)paramMediaType 
                       onSourceType:(UIImagePickerControllerSourceType)paramSourceType{
  
  BOOL result = NO;
  
  if (paramMediaType == nil ||
      [paramMediaType length] == 0){
    return(NO);
  }
  
  if ([UIImagePickerController isSourceTypeAvailable:paramSourceType] == NO){
    return(NO);
  }
  
  NSArray *mediaTypes = [UIImagePickerController 
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
  
  result = [self doesCameraSupportMediaType:(NSString *)kUTTypeMovie
                               onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  isCameraAvailable{
  
  return([UIImagePickerController 
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]);
  
}

/* ------------------------------- */

- (void) imagePickerController
        :(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info{
  
  NSLog(@"Picker returned successfully.");
  
  NSString     *mediaType = [info objectForKey:
                             UIImagePickerControllerMediaType];
  
  /* -------------- */
  
  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie] == YES){
    
    NSURL *urlOfVideo = 
    [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSLog(@"Video URL = %@", urlOfVideo);
    
    NSError *dataReadingError = nil;
    
    NSData *videoData = 
    [NSData dataWithContentsOfURL:urlOfVideo
                          options:NSDataReadingMapped
                            error:&dataReadingError];
    
    if (videoData != nil){
      /* We were able to read the data */
      NSLog(@"Successfully loaded the data.");
    } else {
      /* We failed to read the data. Use the dataReadingError
       variable to determine what the error is */
      NSLog(@"Failed to load the data with error = %@", 
            dataReadingError);
    }
    
  }
    
  /* -------------- */
  
  [picker dismissModalViewControllerAnimated:YES];
  
  
}

/* ------------------------------- */

- (void) imagePickerControllerDidCancel
         :(UIImagePickerController *)picker{
  
  NSLog(@"Picker was cancelled");
  
  [picker dismissModalViewControllerAnimated:YES];
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self isCameraAvailable] == YES &&
      [self doesCameraSupportShootingVideos] == YES){
    
    UIImagePickerController *imagePicker = 
    [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypeCamera;
    
    /* We will only allow the user to shoot videos. 
     Note that we must first detect if the camera on the
     user's iOS device allows us to shoot videos. We determined
     this using the doesCameraSupportShootingVideos metohd */
    NSString *requiredMediaType = (NSString *)kUTTypeMovie;
    
    imagePicker.mediaTypes = 
    [NSArray arrayWithObject:requiredMediaType];
    
    /* Allow the user to trim/edit the video once they are done */
    imagePicker.allowsEditing = YES;
    
    /* Record in high quality */
    imagePicker.videoQuality = 
    UIImagePickerControllerQualityTypeHigh;
    
    /* Only allow 30 seconds of recording */
    imagePicker.videoMaximumDuration = 30.0f;
    
    /* The current view controller will receive the 
     delegate messages */
    imagePicker.delegate = self;
    
    /* Present the image picker as a modal view controller */
    [self presentModalViewController:imagePicker
                            animated:YES];
    
    [imagePicker release];
    
  } else {
    NSLog(@"The camera is not available.");
  }
  
}

/* ------------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  if ([self isCameraAvailable] == YES &&
//      [self doesCameraSupportShootingVideos] == YES){
//    
//    UIImagePickerController *imagePicker = 
//    [[UIImagePickerController alloc] init];
//    
//    imagePicker.sourceType = 
//    UIImagePickerControllerSourceTypeCamera;
//    
//    NSString *requiredMediaType = (NSString *)kUTTypeMovie;
//        
//    imagePicker.mediaTypes = 
//    [NSArray arrayWithObject:requiredMediaType];
//    
//    imagePicker.allowsEditing = YES;
//    
//    imagePicker.delegate = self;
//    
//    [self presentModalViewController:imagePicker
//                            animated:YES];
//    
//    [imagePicker release];
//    
//  } else {
//    NSLog(@"The camera is not available.");
//  }
//  
//}

/* ------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
}

/* ------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

/* ------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* ------------------------------- */

@end
