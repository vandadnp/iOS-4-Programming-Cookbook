//
//  AudioAndVideoViewController.h
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

/* -------------------------- */

@interface AudioAndVideoViewController : UIViewController 
           <MPMediaPickerControllerDelegate>{
@public
  MPMusicPlayerController *myMusicPlayer;
}

/* -------------------------- */

@property (nonatomic, retain) MPMusicPlayerController *myMusicPlayer;

/* -------------------------- */

- (IBAction)  displayMediaPickerAndPlayItem:(id)paramSender;
- (IBAction)  stopPlayingAudio:(id)paramSender;

/* -------------------------- */

@end