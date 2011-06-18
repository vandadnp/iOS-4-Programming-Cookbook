//
//  RootViewController.m
//  Motion
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* ----------------------------------- */

@implementation RootViewController

/* ----------------------------------- */

@synthesize motionManager;

/* ----------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    /* Allocate and initialize the motion manager here */
    CMMotionManager *newMotionManager = 
    [[CMMotionManager alloc] init];
    
    motionManager = [newMotionManager retain];
    [newMotionManager release];
    
  }
  
  return(self);
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ([self.motionManager isGyroAvailable]){
    
    /* Start the gyroscope if it is not active already */
    if ([self.motionManager isGyroActive] == NO){
      /* Update us forty times a second */
      [self.motionManager setGyroUpdateInterval:1.0f / 40.0f];
      /* And on a handler block object */
      
      /* Receive the gyroscope data on this block */
      [self.motionManager 
       startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
       withHandler:^(CMGyroData *gyroData, NSError *error){
         
         NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
         NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
         NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
         
       }];
      
    }
  } else {
    NSLog(@"Gyroscope is not available.");
  }
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self.motionManager isGyroAvailable] &&
      [self.motionManager isGyroActive]){
    [self.motionManager stopGyroUpdates];
  }
  
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ----------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ----------------------------------- */

- (void)dealloc {
  [motionManager release];
  [super dealloc];
}

/* ----------------------------------- */

@end