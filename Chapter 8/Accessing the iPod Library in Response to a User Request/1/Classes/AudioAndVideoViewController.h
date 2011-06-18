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

@interface AudioAndVideoViewController : UIViewController 
           <MPMediaPickerControllerDelegate>{
}

/* -------------------------- */

- (IBAction) displayMediaPicker:(id)paramSender;

/* -------------------------- */

@end