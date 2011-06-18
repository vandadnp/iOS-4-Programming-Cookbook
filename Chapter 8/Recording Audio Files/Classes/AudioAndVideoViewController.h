//
//  AudioAndVideoViewController.h
//  AudioAndVideo
//
//  Created by Vandad Nahavandipoor on 10-07-06.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

/* -------------------------- */

@interface AudioAndVideoViewController : UIViewController 
           <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
@public
  AVAudioRecorder       *audioRecorder;
  AVAudioPlayer         *audioPlayer;
}

/* -------------------------- */

@property (nonatomic, retain) AVAudioRecorder   *audioRecorder;
@property (nonatomic, retain) AVAudioPlayer     *audioPlayer;

/* -------------------------- */

- (NSString *)      audioRecordingPath;
- (NSDictionary *)  audioRecordingSettings;

/* -------------------------- */

@end