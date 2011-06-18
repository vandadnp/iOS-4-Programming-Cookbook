//
//  RootViewController.m
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

/* ------------------------------- */

@implementation RootViewController

/* ------------------------------- */

@synthesize assetsLibrary;

/* ------------------------------- */

void (^groupAssetEnumerationBlock)(ALAsset *, NSUInteger, BOOL *) = 
^(ALAsset *result, NSUInteger index, BOOL *stop){

  static BOOL firstVideoIsFound = NO;
  
  /* We don't want to get all the videos. As soon as we get
   the first video, we want to end the enumeration */
  if (firstVideoIsFound == YES){
    *stop = YES;
    return;
  }
  
  /* Get the asset type */
  NSString *assetType = [result valueForProperty:ALAssetPropertyType];
  
  if ([assetType isEqualToString:ALAssetTypeVideo] == YES){
    NSLog(@"This is a video asset");
    firstVideoIsFound = YES;
    
    /* Get the asset's representation object */
    ALAssetRepresentation *assetRepresentation = 
    [result defaultRepresentation];
    
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
    
    NSLog(@"Finished reading and storing the \
          video in the documents folder");
    
  }
  
};

/* ------------------------------- */

void (^assetGroupEnumerationBlock)(ALAssetsGroup *, BOOL *) = 
^(ALAssetsGroup *group, BOOL *stop){
  

  [group enumerateAssetsUsingBlock:groupAssetEnumerationBlock];
  
};

/* ------------------------------- */

void (^assetGroupEnumerationFailedBlock)(NSError *) = ^(NSError *error){
  
  NSLog(@"Group enumeration Error = %@", error);
  
};

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
  [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                    usingBlock:assetGroupEnumerationBlock
                                  failureBlock:assetGroupEnumerationFailedBlock];
  
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

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    ALAssetsLibrary *newLibrary = [[ALAssetsLibrary alloc] init];
    assetsLibrary = [newLibrary retain];
    [newLibrary release];
    
  }
  
  return(self);
  
}

/* ------------------------------- */

- (void)dealloc {
  [assetsLibrary release];
  [super dealloc];
}

/* ------------------------------- */

@end
