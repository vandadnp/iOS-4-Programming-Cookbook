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

void (^handleFailedToRetrieveAsset)(NSError *) = ^(NSError *error){
  NSLog(@"Failed to retrieve the asset with error = %@", error);
};

/* ------------------------------- */

void (^readVideoDataAndSaveToDocumentsFolder)(ALAsset *) = ^(ALAsset *asset){
  
  ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
  
  const NSUInteger BufferSize = 1024;
  uint8_t     buffer[BufferSize];
  NSUInteger  bytesRead = 0;
  long long   currentOffset = 0;
  NSError     *readingError = nil;
  
  /* Find the documents folder (an array) */
  NSArray *documents =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                      NSUserDomainMask,
                                      YES);
  
  /* Retrieve the one documents folder that we need */
  NSString *documentsFolder = [documents objectAtIndex:0];
  
  /* Construct the path where the video has to be saved */
  NSString *videoPath = [documentsFolder
                         stringByAppendingPathComponent:@"Temp.MOV"];
  
  /* We will use this file handle to write the contents
   of the media assets to the disk */
  NSFileHandle *fileHandle = [NSFileHandle 
                              fileHandleForWritingAtPath:videoPath];
  
  NSLog(@"Starting to read the asset's data and saving to disk...");
  
  do{
    
    /* Read as many bytes as we can put in the buffer */
    bytesRead = [assetRepresentation getBytes:(uint8_t *)&buffer
                                   fromOffset:currentOffset
                                       length:BufferSize
                                        error:&readingError];
    
    /* If we couldn't read anything, we will exit this loop */
    if (bytesRead == 0){
      break;
    }
    
    /* Keep the offset up to date */
    currentOffset += bytesRead;
    
    /* Put the buffer into an NSData */
    NSData *readData = [[NSData alloc] initWithBytes:(const void *)buffer
                                              length:bytesRead];
    /* And write the data to file */
    [fileHandle writeData:readData];
    [readData release];
    
  } while (bytesRead > 0);
  
  NSLog(@"Finished reading and saving the asset to disk");
  
};

/* ------------------------------- */

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info{
  
  NSLog(@"Picker returned successfully.");
  
  NSString     *mediaType = [info objectForKey:
                             UIImagePickerControllerMediaType];
  
  /* -------------- */
  
  if ([mediaType isEqualToString:(NSString *)kUTTypeImage] == YES){
    
    /* Let's get the metadata. This is only for 
     images. Not videos */
    
    UIImage *theImage = nil;
    
    if (picker.allowsEditing == YES){
      theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
      theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    NSLog(@"Image = %@", theImage);
    
  }
  
  else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie] == YES){
    
    /* Now we have to get the movie */
    NSURL *urlOfVideo = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    
    [assetLibrary assetForURL:urlOfVideo 
                  resultBlock:readVideoDataAndSaveToDocumentsFolder
                 failureBlock:handleFailedToRetrieveAsset];
    
    [assetLibrary release];
    
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

- (BOOL) isPhotoLibraryAvailable{
  
  return ([UIImagePickerController 
           isSourceTypeAvailable:
           UIImagePickerControllerSourceTypePhotoLibrary]);
  
}

/* ------------------------------- */

- (BOOL) canUserPickVideosFromPhotoLibrary{
  
  BOOL result = NO;
  
  result = 
  [self 
   doesCameraSupportMediaType:(NSString *)kUTTypeMovie
   onSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  
  return(result);
  
}

/* ------------------------------- */

- (BOOL) canUserPickPhotosFromPhotoLibrary{
  
  BOOL result = NO;
  
  result = 
  [self 
   doesCameraSupportMediaType:(NSString *)kUTTypeImage
   onSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  
  return(result);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self isPhotoLibraryAvailable] == YES){
    
    UIImagePickerController *imagePicker = 
    [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = 
    UIImagePickerControllerSourceTypePhotoLibrary;
    
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    
    if ([self canUserPickPhotosFromPhotoLibrary] == YES){
      [mediaTypes addObject:(NSString *)kUTTypeImage];
    }
    
    if ([self canUserPickVideosFromPhotoLibrary] == YES){
      [mediaTypes addObject:(NSString *)kUTTypeMovie];
    }
    
    imagePicker.mediaTypes = mediaTypes;
    
    imagePicker.delegate = self;
    
    [self presentModalViewController:imagePicker
                            animated:YES];
    
    [imagePicker release];
    [mediaTypes release];
    
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
