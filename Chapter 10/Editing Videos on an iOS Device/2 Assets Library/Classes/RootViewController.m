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

@synthesize videoURLToEdit;

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

- (void)videoEditorController:(UIVideoEditorController *)editor 
     didSaveEditedVideoToPath:(NSString *)editedVideoPath{
  
  NSLog(@"The video editor finished saving video");
  
  NSLog(@"The edited video path is at = %@", editedVideoPath);
  
  [editor dismissModalViewControllerAnimated:YES];
}

/* ------------------------------- */

- (void)videoEditorController:(UIVideoEditorController *)editor 
             didFailWithError:(NSError *)error{
  
  NSLog(@"Video editor error occurred = %@", error);
  
  [editor dismissModalViewControllerAnimated:YES];
}

/* ------------------------------- */

- (void)videoEditorControllerDidCancel
        :(UIVideoEditorController *)editor{
  
  NSLog(@"The video editor was cancelled");
  
  [editor dismissModalViewControllerAnimated:YES];
}

/* ------------------------------- */

void (^handleFailedToRetrieveAsset)(NSError *) = ^(NSError *error){
  NSLog(@"Failed to retrieve the asset with error = %@", error);
};

/* ------------------------------- */

void (^saveVideoAssetToDisk)(ALAsset *) = ^(ALAsset *asset){
  
  /* Get the asset type */
  NSString *assetType = [asset valueForProperty:ALAssetPropertyType];
  
  if ([assetType isEqualToString:ALAssetTypeVideo] == YES){
    NSLog(@"This is a video asset");
    
    /* Get the asset's representation object */
    ALAssetRepresentation *assetRepresentation = 
    [asset defaultRepresentation];
    
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
    NSString *videoPath = 
    [documentsFolder
     stringByAppendingPathComponent:@"Temp.MOV"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    /* Create the file if it doesn't exist already */
    if ([fileManager fileExistsAtPath:videoPath] == NO){
      [fileManager createFileAtPath:videoPath
                           contents:nil
                         attributes:nil];
    }
    
    [fileManager release];    
    
    /* We will use this file handle to write the contents
     of the media assets to the disk */
    NSFileHandle *fileHandle = 
    [NSFileHandle 
     fileHandleForWritingAtPath:videoPath];
    
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
      NSData *readData = [[NSData alloc] 
                          initWithBytes:(const void *)buffer
                          length:bytesRead];
      
      /* And write the data to file */
      [fileHandle writeData:readData];
      [readData release];
      
    } while (bytesRead > 0);
    
    NSLog(@"Finished reading and storing the video \
          in the documents folder");
    
  }
  
};

/* ------------------------------- */

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info{
  
  NSLog(@"Picker returned successfully.");
  
  NSString     *mediaType = [info objectForKey:
                             UIImagePickerControllerMediaType];
  
  /* -------------- */
  
  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie] == YES){
    
    /* We now have to save the video into the documents folder of our
     application and then show the video editor based on the new path */
    
    NSURL *urlOfVideo = 
    [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    
    [assetLibrary assetForURL:urlOfVideo 
                  resultBlock:saveVideoAssetToDisk
                 failureBlock:handleFailedToRetrieveAsset];
    
    [assetLibrary release];
    
    /* Find the documents folder (an array) */
    NSArray *documents =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                        NSUserDomainMask,
                                        YES);
    
    /* Retrieve the one documents folder that we need */
    NSString *documentsFolder = [documents objectAtIndex:0];
    
    /* Construct the path where the video has to be saved */
    NSString *videoPath = 
    [documentsFolder 
     stringByAppendingPathComponent:@"Temp.MOV"];
    
    self.videoURLToEdit = [NSURL URLWithString:videoPath];
    
  }
        
  /* -------------- */
  
  [picker dismissModalViewControllerAnimated:YES];
  
}

/* ------------------------------- */

- (void) imagePickerControllerDidCancel
         :(UIImagePickerController *)picker{
  
  NSLog(@"Picker was cancelled");
  
  self.videoURLToEdit = nil;
  
  [picker dismissModalViewControllerAnimated:YES];
  
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

- (BOOL) isPhotoLibraryAvailable{
  
  return ([UIImagePickerController 
           isSourceTypeAvailable:
           UIImagePickerControllerSourceTypePhotoLibrary]);
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* First see if we are allowed to access the photo library and
   if the user is able to pick videos from the photo library */
  if ([self isPhotoLibraryAvailable] == YES &&
      [self canUserPickVideosFromPhotoLibrary] == YES){
    
    UIImagePickerController *imagePicker = 
    [[UIImagePickerController alloc] init];
    
    /* Set the source type to photo library */
    imagePicker.sourceType = 
    UIImagePickerControllerSourceTypePhotoLibrary;
    
    /* And we want our user to be able to pick movies from the library */
    NSArray  *mediaTypes = 
    [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
    
    imagePicker.mediaTypes = mediaTypes;
    
    /* Set the delegate to the current view controller */
    imagePicker.delegate = self;
    
    /* Present our image picker */
    [self presentModalViewController:imagePicker
                            animated:YES];
    
    [imagePicker release];
    
  }
  
}

/* ------------------------------- */

- (void) viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  if (self.videoURLToEdit != nil){
    
    NSString *videoPath = [self.videoURLToEdit absoluteString];
    
    /* First let's make sure the video editor is able to edit the
     video at the path in our documents folder */
    if ([UIVideoEditorController canEditVideoAtPath:videoPath] == YES){
      
      /* Instantiate the video editor */
      UIVideoEditorController *videoEditor = 
      [[UIVideoEditorController alloc] init];
      
      /* We become the delegate of the video editor */
      videoEditor.delegate = self;
      
      /* Make sure to set the path of the video */
      videoEditor.videoPath = videoPath;
      
      /* And present the video editor */
      [self presentModalViewController:videoEditor
                              animated:YES];
      
      [videoEditor release];
      
      self.videoURLToEdit = nil;
      
    } else {
      NSLog(@"Cannot edit the video at this path");
    }
    
  }
  
}

/* ------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
}

/* ------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* ------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ------------------------------- */

- (void)dealloc {
  [videoURLToEdit release];
  [super dealloc];
}

/* ------------------------------- */

@end