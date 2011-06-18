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
               bundle:(NSBundle *)nibBundleOrNil {
  
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

void (^accelerometerHandler)(CMAccelerometerData *, NSError *) = 
      ^(CMAccelerometerData *accelerometerData, NSError *error){
  
  NSLog(@"X = %.04f, Y = %.04f, Z = %.04f", 
        accelerometerData.acceleration.x,
        accelerometerData.acceleration.y,
        accelerometerData.acceleration.z);
  
};

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Is the accelerometer available? */
  if ([self.motionManager isAccelerometerAvailable] == YES){
    
    /* Start the accelerometer if it is not active already */
    if ([self.motionManager isAccelerometerActive] == NO){
      /* Update us twice a second */
      [self.motionManager 
       setAccelerometerUpdateInterval:1.0f / 2.0f];
      /* And on a handler block object */
      [self.motionManager 
       startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
       withHandler:accelerometerHandler];
    }
  }
  
}


/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  if ([self.motionManager isAccelerometerAvailable] == YES &&
      [self.motionManager isAccelerometerActive] == YES){
    [self.motionManager stopAccelerometerUpdates];
  }
  
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
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