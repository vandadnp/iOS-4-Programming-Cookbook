//
//  AudioAndVideoViewController.m
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import "AudioAndVideoViewController.h"

/* -------------------------- */

@implementation AudioAndVideoViewController

/* -------------------------- */

- (void) mediaPicker:(MPMediaPickerController *)mediaPicker 
   didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
  
  NSLog(@"Media Picker returned");
  
  for (MPMediaItem *thisItem in mediaItemCollection.items){
    
    NSURL     *itemURL = 
    [thisItem valueForProperty:MPMediaItemPropertyAssetURL];
    
    NSString  *itemTitle = 
    [thisItem valueForProperty:MPMediaItemPropertyTitle];
    
    NSString  *itemArtist = 
    [thisItem valueForProperty:MPMediaItemPropertyArtist];
    
    MPMediaItemArtwork *itemArtwork = 
      [thisItem valueForProperty:MPMediaItemPropertyArtwork];
    
    NSLog(@"Item URL = %@", itemURL);
    NSLog(@"Item Title = %@", itemTitle);
    NSLog(@"Item Artist = %@", itemArtist);
    NSLog(@"Item Artwork = %@", itemArtwork);
  }
  
  [mediaPicker dismissModalViewControllerAnimated:YES];
  
}

/* -------------------------- */

- (void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
  
  /* The media picker was cancelled */
  NSLog(@"Media Picker was cancelled");
  
  [mediaPicker dismissModalViewControllerAnimated:YES];
  
}

/* -------------------------- */

- (IBAction) displayMediaPicker:(id)paramSender{
  
  MPMediaPickerController *mediaPicker = 
  [[MPMediaPickerController alloc] 
   initWithMediaTypes:MPMediaTypeAny];
  
  if (mediaPicker != nil){
    
    NSLog(@"Successfully instantiated a media picker.");
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    
    [self.navigationController presentModalViewController:mediaPicker
                                                 animated:YES];
    [mediaPicker release];
    
  } else {
    NSLog(@"Could not instantiate a media picker.");
  }
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self displayMediaPicker:nil];
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return(YES);
}

/* -------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* -------------------------- */

@end
