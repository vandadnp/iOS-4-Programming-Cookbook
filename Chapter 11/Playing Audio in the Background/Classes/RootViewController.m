//
//  RootViewController.m
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ------------------------------------------- */

@implementation RootViewController

/* ------------------------------------------- */

@synthesize audioPlayer;

/* ------------------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil 
                              bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
}

/* ------------------------------------------- */

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{

  /* Audio Session is interrupted. 
   The player will be paused here */
  
}

/* ------------------------------------------- */

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player 
                         withFlags:(NSUInteger)flags{
  
  /* Check the flags, if we can resume the audio, 
   then we should do it here */
  
  if (flags == AVAudioSessionInterruptionFlags_ShouldResume){
    [player play];
  }
  
}

/* ------------------------------------------- */

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player 
                       successfully:(BOOL)flag{
  
  NSLog(@"Finished playing the song");
  
  /* The flag parameter tells us if the playback was successfully
   finished or not */
  
  if ([player isEqual:self.audioPlayer] == YES){
    self.audioPlayer = nil;
  } else {
    [player release];
  }
  
}

/* ------------------------------------------- */

- (void) startPlayingAudio{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSError *audioSessionError = nil;
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  if ([audioSession setCategory:AVAudioSessionCategoryPlayback
                          error:&audioSessionError] == YES){
    NSLog(@"Successfully set the audio session.");
  } else {
    NSLog(@"Could not set the audio session");
  }
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSString *filePath = [mainBundle pathForResource:@"MySong"
                                            ofType:@"mp3"];
  
  NSData   *fileData = [NSData dataWithContentsOfFile:filePath];
  
  NSError  *error = nil;
  
  /* Start the audio player */  
  AVAudioPlayer *newPlayer = 
  [[AVAudioPlayer alloc] initWithData:fileData
                                error:&error];
  
  self.audioPlayer = newPlayer;
  [newPlayer release];
  
  /* Did we get an instance of AVAudioPlayer? */
  if (self.audioPlayer != nil){
    /* Set the delegate and start playing */
    self.audioPlayer.delegate = self;
    if ([self.audioPlayer prepareToPlay] == YES &&
        [self.audioPlayer play] == YES){
      /* Successfully started playing */
    } else {
      /* Failed to play */
    }
  } else {
    /* Failed to instantiate AVAudioPlayer */
  }
  
  [pool release];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [NSThread 
   detachNewThreadSelector:@selector(startPlayingAudio)
   toTarget:self
   withObject:nil];
  
}

/* ------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  if([self.audioPlayer isPlaying] == YES){
    [self.audioPlayer stop];
  }
  self.audioPlayer = nil;
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* ------------------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ------------------------------------------- */

- (void)dealloc {
  [audioPlayer release];
  [super dealloc];
}

/* ------------------------------------------- */

@end