//
//  AudioAndVideoViewController.h
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

/* -------------------------- */

@interface AudioAndVideoViewController : UIViewController{
@public
  MPMoviePlayerController *moviePlayer;
}

/* -------------------------- */

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

/* -------------------------- */

- (IBAction) startPlayingVideo:(id)paramSender;
- (IBAction) stopPlayingVideo:(id)paramSender;

/* -------------------------- */

@end