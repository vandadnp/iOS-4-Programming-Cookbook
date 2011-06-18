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

- (BOOL)  doesCameraSupportTakingPhotos{
  
  BOOL result = NO;
  
  result = [self doesCameraSupportMediaType:(NSString *)kUTTypeImage
                               onSourceType:UIImagePickerControllerSourceTypeCamera];
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL)  isCameraAvailable{
  
  return([UIImagePickerController 
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]);
  
}

/* ------------------------------- */

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info{
  
  NSLog(@"Picker returned successfully.");
  
  NSString     *mediaType = [info objectForKey:
                             UIImagePickerControllerMediaType];
  
  /* -------------- */
  
  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie] == YES){
    
    NSURL *urlOfVideo = 
    [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSLog(@"Video URL = %@", urlOfVideo);
    
  }
  
  /* -------------- */
  
  else if ([mediaType isEqualToString:(NSString *)kUTTypeImage] == YES){
    
    /* Let's get the metadata. This is only for 
     images. Not videos */
    
    NSDictionary *metadata = 
    [info objectForKey:
     UIImagePickerControllerMediaMetadata];
    
    UIImage *theImage = 
    [info objectForKey:
     UIImagePickerControllerOriginalImage];
    
    NSLog(@"Image Metadata = %@", metadata);
    NSLog(@"Image = %@", theImage);
    
    
  }
  
  /* -------------- */
  
  [picker dismissModalViewControllerAnimated:YES];
  
  
}

/* ------------------------------- */

- (void)    imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  
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
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    NSString *requiredMediaType = (NSString *)kUTTypeAudio;
    
    imagePicker.mediaTypes = 
    [NSArray arrayWithObject:requiredMediaType];
    
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
