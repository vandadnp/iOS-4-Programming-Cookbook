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
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  doesCameraSupportTakingPhotos{
  
  BOOL result = NO;
  
  result = [self doesCameraSupportMediaType:(NSString *)kUTTypeImage
                               onSourceType:UIImagePickerControllerSourceTypeCamera];
  
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

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage
          didFinishSavingWithError:(NSError *)paramError
                       contextInfo:(void *)paramContextInfo{
  
  if (paramError == nil){
    NSLog(@"Image was saved successfully.");
  } else {
    NSLog(@"An error happened while saving the image.");
    NSLog(@"Error = %@", paramError);
  }
  
}

/* ------------------------------- */

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info{
  
  NSLog(@"Picker returned successfully.");
    
  NSString     *mediaType = [info objectForKey:
                             UIImagePickerControllerMediaType];
  
  /* -------------- */
  
  if ([mediaType isEqualToString:(NSString *)kUTTypeImage] == YES){
    
    UIImage *theImage = nil;
    
    if (picker.allowsEditing == YES){
      
      theImage = 
      [info 
       objectForKey:UIImagePickerControllerEditedImage];
      
    } else {
      
      theImage = 
      [info 
       objectForKey:UIImagePickerControllerOriginalImage];
      
    }
    
    /* To avoid a very long line of text, we will break the
     selector's name into two lines using the backslash */
    NSString *targetSelectorAsString = 
    @"imageWasSavedSuccessfully:didFinishSavingWithError:\
    contextInfo:";
    
    SEL targetSelector = 
    NSSelectorFromString(targetSelectorAsString);
    
    NSLog(@"Saving the photo...");
    UIImageWriteToSavedPhotosAlbum(theImage, 
                                   self,
                                   targetSelector, 
                                   nil);
    
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
      [self doesCameraSupportTakingPhotos] == YES){
    
    UIImagePickerController *imagePicker = 
    [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = 
    UIImagePickerControllerSourceTypeCamera;
        
    imagePicker.mediaTypes = 
    [UIImagePickerController 
     availableMediaTypesForSourceType:
     imagePicker.sourceType];
    
    imagePicker.allowsEditing = YES;
    
    imagePicker.delegate = self;
    
    [self presentModalViewController:imagePicker
                            animated:YES];
    
    [imagePicker release];
    
  } else {
    NSLog(@"The camera is not available.");
  }
  
}

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
