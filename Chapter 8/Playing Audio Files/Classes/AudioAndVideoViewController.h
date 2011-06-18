//
//  AudioAndVideoViewController.h
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/* -------------------------- */

@interface AudioAndVideoViewController : UIViewController
                                         <AVAudioPlayerDelegate> {
@public
  AVAudioPlayer       *audioPlayer;
}

/* -------------------------- */

@property (nonatomic, retain) AVAudioPlayer       *audioPlayer;

/* -------------------------- */

@end

