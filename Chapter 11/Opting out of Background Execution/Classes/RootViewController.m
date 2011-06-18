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

@synthesize isExecutingInBackground;

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

- (BOOL) isMultitaskingSupported{
  
  BOOL result = NO;
  
  UIDevice *device = [UIDevice currentDevice];
  
  if (device != nil){
    if ([device respondsToSelector:
         @selector(isMultitaskingSupported)] == YES){
      /* Make sure this only gets compiled on iOS SDK 4.0 and
       later so we won't get any compile-time warnings */
      #ifdef __IPHONE_4_0
        #if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0)
          result = [device isMultitaskingSupported];
        #endif
      #endif
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) saveUserScoreToDisk{
  
  /* Save the score */
  NSLog(@"Saving user's score to the disk...");
  
}

/* ------------------------------------------- */

- (void) loadUserScoreFromDisk{
  
  NSLog(@"Loading user's score from the disk...");
  
}

/* ------------------------------------------- */

- (void) saveCurrentLevelDataToDisk{
  
  /* Save the current game level to disk. Where in the 
   level the user is, how much she have advanced and this
   level and etc */
  
  NSLog(@"Saving the current level's data to the disk...");
  
}

/* ------------------------------------------- */

- (NSData *) loadCurrentLevelDataFromDisk{
  
  NSData *result = nil;
  
  /* Load the current level from the disk and put
   it in an NSData (result) if possible. The level doesn't
   necessarily have to be loaded into an NSData. This is just
   an example */
  
  NSLog(@"Loading the current level's data from the disk...");
  
  return(result);
  
}

/* ------------------------------------------- */

- (void) pauseGameEngine{
  
  NSLog(@"Pausing the game engine...");
  
}

/* ------------------------------------------- */

- (void) resumeGameEngine{
  
  NSLog(@"Resuming the game engine...");
  
}

/* ------------------------------------------- */

- (void) saveGameState{
  
  [self pauseGameEngine];
  [self saveUserScoreToDisk];
  [self saveCurrentLevelDataToDisk];
  
}

/* ------------------------------------------- */

- (void) loadGameState{
  
  [self loadUserScoreFromDisk];
  [self loadCurrentLevelDataFromDisk];
  [self resumeGameEngine];
  
}

/* ------------------------------------------- */

- (void) handleEnteringBackground:(NSNotification *)paramNotification{
  
  /* We have entered background */
  NSLog(@"Going to background.");
  
  self.isExecutingInBackground = YES;
  
  [self saveGameState];

}

/* ------------------------------------------- */

- (void) handleEnteringForeground:(NSNotification *)paramNotification{
  
  /* We have entered foreground */
  NSLog(@"Coming to foreground");
  
  self.isExecutingInBackground = NO;
  
  [self loadGameState];
  
}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Listen for the notifications sent to our application when the
   user puts the application in the background or when 
   the application is brought to the foreground  */
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self
     selector:@selector(handleEnteringBackground:)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleEnteringForeground:)
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
  } else {
    NSLog(@"Multitasking is not enabled.");
  }
    
}

/* ------------------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self isMultitaskingSupported] == YES){
    
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
  }
  
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
  
  [super dealloc];
}

/* ------------------------------------------- */

@end
