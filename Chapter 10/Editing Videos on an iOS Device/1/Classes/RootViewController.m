//
//  RootViewController.m
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

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

- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor{
  
  NSLog(@"The video editor was cancelled");
  
  [editor dismissModalViewControllerAnimated:YES];
}

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
    
    NSURL *urlOfVideo = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSError *readingError = nil;
    /* Load the contents of the video into an NSData instance */
    NSData *videoData = [NSData dataWithContentsOfURL:urlOfVideo
                                              options:NSDataReadingMapped
                                                error:&readingError];
    
    if (videoData == nil){
      
      NSLog(@"Failed to load the video data with error = %@", readingError);
      
    } else {
      
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
      
      /* Save the video to the documents folder */
      [videoData writeToFile:videoPath
                  atomically:YES];
      
      /* Store this URL so the viewDidAppear: method will catch it */
      self.videoURLToEdit = [NSURL URLWithString:videoPath];
    }
    
  }
  
  /* -------------- */
  
  [picker dismissModalViewControllerAnimated:YES];
  
}

/* ------------------------------- */

- (void)    imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  
  NSLog(@"Picker was cancelled");
  
  self.videoURLToEdit = nil;
  
  [picker dismissModalViewControllerAnimated:YES];
  
}

/* ------------------------------- */

- (BOOL) canUserPickVideosFromPhotoLibrary{
  
  BOOL result = NO;
  
  result = [self doesCameraSupportMediaType:(NSString *)kUTTypeMovie
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
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    /* And we want our user to be able to pick movies from the library */
    NSArray  *mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
    
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