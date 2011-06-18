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

void (^handleVideoWasSavedSuccessfully)(NSURL *, NSError *) = 
^(NSURL *assetURL, NSError *error){
  
  if (error == nil){
    NSLog(@"no errors happened");
  } else {
    NSLog(@"Error happened while saving the video.");
    NSLog(@"The error is = %@", error);
  }
  
};

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* First get the URL of the video in the application bundle */
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSURL *videoFileURL = [mainBundle URLForResource:@"MyVideo"
                                     withExtension:@"MOV"];

  if (videoFileURL != nil){
    
    /* Now attempt to save the video to the photo library using
     the assets library object */
    [self.assetsLibrary 
     writeVideoAtPathToSavedPhotosAlbum:videoFileURL
     completionBlock:handleVideoWasSavedSuccessfully];
    
  } else {
    NSLog(@"Could not find the MyVideo.MOV file in the app bundle");
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
  [assetsLibrary release];
  [super dealloc];
}

/* ------------------------------- */

@end
