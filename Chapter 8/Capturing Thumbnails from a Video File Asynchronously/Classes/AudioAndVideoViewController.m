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

@synthesize moviePlayer;

/* -------------------------- */

//- (IBAction) startPlayingVideo:(id)paramSender{
//  
//  NSBundle *mainBundle = [NSBundle mainBundle];
//  
//  NSString *urlAsString = [mainBundle pathForResource:@"Sample"
//                                               ofType:@"m4v"];
//  
//  NSURL    *url = [NSURL URLWithString:urlAsString];
//  
//  MPMoviePlayerController *newMoviePlayer =
//  [[MPMoviePlayerController alloc] initWithContentURL:url];
//  
//  self.moviePlayer = newMoviePlayer;
//  
//  [newMoviePlayer release];
//  
//  if (self.moviePlayer != nil){
//    
//    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
//    
//    UIView *playerView = self.moviePlayer.view;
//
//    CGRect halfRect = self.view.bounds;
//    halfRect.size.width /= 2.0f;
//    halfRect.size.height /= 2.0f;
//    
//    playerView.frame = halfRect;
//    playerView.center = self.view.center;
//    
//    [self.view addSubview:playerView];
//    
//    NSLog(@"Successfully instantiated the movie player.");
//    
//    //[self.moviePlayer play];
//
//  } else {
//    NSLog(@"Failed to instantiate the movie player.");
//  }
//  
//}

/* -------------------------- */

- (void) videoHasFinishedPlaying:(NSNotification *)paramNotification{
  
  /* Find out what the reason was for the player to stop */
  NSNumber *reason = 
  [paramNotification.userInfo
   valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
  
  if (reason != nil){
    NSInteger reasonAsInteger = [reason integerValue];
    
    switch (reasonAsInteger){
      case MPMovieFinishReasonPlaybackEnded:{
        /* The movie ended normally */
        break;
      }
      case MPMovieFinishReasonPlaybackError:{
        /* An error happened and the movie ended */
        break;
      }
      case MPMovieFinishReasonUserExited:{
        /* The user exited the player */
        break;
      }
    }
    
    NSLog(@"Finish Reason = %d", reasonAsInteger);
    [self stopPlayingVideo:nil];
    self.moviePlayer = nil;
  } /* if (Reason != nil){ */
  
}

/* -------------------------- */

- (void) videoThumbnailIsAvailable:(NSNotification *)paramNotification{
  
  MPMoviePlayerController *controller = [paramNotification object];
  
  if (controller != nil &&
      [controller isEqual:self.moviePlayer] == YES){
    
    NSLog(@"Screen shot is available");
    
    /* Now get the thumbnail out of the user info dictionary */
    UIImage *thumbnail = 
      [paramNotification.userInfo 
       objectForKey:MPMoviePlayerThumbnailImageKey];
    
    if (thumbnail != nil){
      
      /* We got the thumbnail image. You can now use it here */
      
    }
    
  }
  
}

/* -------------------------- */

- (IBAction) startPlayingVideo:(id)paramSender{
  
  /* First let's construct the URL of the file in our application bundle
   that needs to get played by the movie player */
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSString *urlAsString = [mainBundle pathForResource:@"Sample"
                                               ofType:@"m4v"];
  
  NSURL    *url = [NSURL fileURLWithPath:urlAsString];
  
  /* If we have already created a movie player before,
   let's try to stop it */
  self.moviePlayer = nil;
  
  /* Now create a new movie player using the URL */
  MPMoviePlayerController *newMoviePlayer = 
  [[MPMoviePlayerController alloc] initWithContentURL:url];
  self.moviePlayer = newMoviePlayer;
  [newMoviePlayer release];
  
  if (self.moviePlayer != nil){
    
    /* Listen for the notification that the movie player 
     sends us whenever it finishes playing a video file */
    [[NSNotificationCenter defaultCenter] 
     addObserver:self
     selector:@selector(videoHasFinishedPlaying:)
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(videoThumbnailIsAvailable:)
     name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
     object:self.moviePlayer];
    
    NSLog(@"Successfully instantiated the movie player.");
    
    /* Scale the movie player to fit the aspect ratio */
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    /* Get a reference to the view of the movie player */
    UIView *playerView = self.moviePlayer.view;
    
    /* We want to display the movie on our view */
    [self.view addSubview:playerView];
    
    /* Let's start playing the video in full screen mode */
    [self.moviePlayer play];
    
    [self.moviePlayer setFullscreen:YES
                           animated:YES];
    
    /* Capture the frame at the third second into the movie */
    NSNumber *thirdSecondThumbnail = [NSNumber numberWithFloat:3.0f];
    
    /* We can ask to capture as many frames as we 
     want. But for now, we are just asking to capture one frame */
    NSArray  *requestedThumbnails = 
    [NSArray arrayWithObject:thirdSecondThumbnail];
    
    /* Ask the movie player to capture this frame for us */
    [self.moviePlayer 
     requestThumbnailImagesAtTimes:requestedThumbnails
     timeOption:MPMovieTimeOptionExact];
    
  } else {
    NSLog(@"Failed to instantiate the movie player.");
  }
  
}

/* -------------------------- */

- (IBAction) stopPlayingVideo:(id)paramSender {
  
  if (self.moviePlayer != nil){
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
     object:self.moviePlayer];
    
    [self.moviePlayer stop];
    
    if (self.moviePlayer.view != nil &&
        self.moviePlayer.view.superview != nil &&
        [self.moviePlayer.view.superview isEqual:self.view] == YES){
      [self.moviePlayer.view removeFromSuperview];
    }
    
  }
  
}

/* -------------------------- */

- (void) viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self startPlayingVideo:nil];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
}

/* -------------------------- */

- (void) viewDidUnload{
  
  [self stopPlayingVideo:nil];
  self.moviePlayer = nil;
  [super viewDidUnload];
  
}

/* -------------------------- */

- (void) willAnimateRotationToInterfaceOrientation
        :(UIInterfaceOrientation)toInterfaceOrientation 
        duration:(NSTimeInterval)duration{
  
  if (self.moviePlayer != nil &&
      self.moviePlayer.view != nil &&
      self.moviePlayer.view.superview != nil &&
      [self.moviePlayer.view.superview isEqual:self.view] == YES){
    
    UIView *playerView = self.moviePlayer.view;
    
    CGRect halfRect = self.view.bounds;
    halfRect.size.width /= 2.0f;
    halfRect.size.height /= 2.0f;
    
    playerView.frame = halfRect;
    playerView.center = self.view.center;
    
  }
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return(YES);
}

/* -------------------------- */

- (void)dealloc {
  
  [self stopPlayingVideo:nil];
  moviePlayer = nil;
  
  [super dealloc];
}

/* -------------------------- */

@end
