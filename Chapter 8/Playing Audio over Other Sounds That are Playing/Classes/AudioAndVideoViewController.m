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

@synthesize audioPlayer;

/* -------------------------- */

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
  
  /* The audio session has been deactivated here */
  
}

/* -------------------------- */

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
  
  /* For iOS lower than 4 */
  
}

/* -------------------------- */

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player 
                         withFlags:(NSUInteger)flags{
  
  /* For iOS 4 and later */
  if (flags == AVAudioSessionInterruptionFlags_ShouldResume){
    [player play];
  }
  
}

/* -------------------------- */

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player 
                       successfully:(BOOL)flag{
  
  if (flag == YES){
    NSLog(@"Audio player stopped correctly.");
  } else {
    NSLog(@"Audio player did not stop correctly.");
  }
  
  if ([player isEqual:self.audioPlayer] == YES){
    self.audioPlayer = nil;
  } else {
    [player release];
  }
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSString *filePath = [mainBundle pathForResource:@"MySong"
                                            ofType:@"mp3"];
  
  NSError *audioSessionError = nil;
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  if ([audioSession setCategory:AVAudioSessionCategoryAmbient
                          error:&audioSessionError] == YES){
    NSLog(@"Successfully set the audio session.");
  } else {
    NSLog(@"Could not set the audio session");
  }
  
  NSData *fileData = [NSData dataWithContentsOfFile:filePath];
  
  NSError *audioPlayerError = nil;
  
  AVAudioPlayer *newPlayer = 
  [[AVAudioPlayer alloc] initWithData:fileData 
                                error:&audioPlayerError];
  self.audioPlayer = newPlayer;
  [newPlayer release];
  
  if (self.audioPlayer != nil){
    
    self.audioPlayer.delegate = self;
    
       if ([self.audioPlayer prepareToPlay] == YES &&
        [self.audioPlayer play] == YES){
      NSLog(@"Successfully started playing.");
      
    } else {
      NSLog(@"Failed to play the audio file.");
      self.audioPlayer = nil;
    }
    
  } else {
    NSLog(@"Could not instantiate the audio player.");
  }
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  if (self.audioPlayer != nil){
    if ([self.audioPlayer isPlaying] == YES){
      [self.audioPlayer stop];
    }    
    self.audioPlayer = nil;
  }
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return(YES);
}

/* -------------------------- */

- (void)dealloc {
  
  if (audioPlayer != nil){
    if ([audioPlayer isPlaying] == YES){
      [audioPlayer stop];
    }
  }
  [audioPlayer release];
  
  [super dealloc];
}

/* -------------------------- */

@end
