//
//  RootViewController.h
//  Multitasking
//
//  Created by Vandad Nahavandipoor on 10-07-23.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/* ------------------------------------------- */

@interface RootViewController : UIViewController 
                                <AVAudioPlayerDelegate> {
@public
  AVAudioPlayer   *audioPlayer;
}

/* ------------------------------------------- */

@property (nonatomic, retain) AVAudioPlayer   *audioPlayer;

/* ------------------------------------------- */

@end
