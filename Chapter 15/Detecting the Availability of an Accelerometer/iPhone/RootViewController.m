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
@synthesize myButton;

/* ----------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    CMMotionManager *newMotionManager = 
    [[CMMotionManager alloc] init];
    
    motionManager = [newMotionManager retain];
    [newMotionManager release];
    
    NSString *accelerometerAvailability = @"is not";
    
    if ([motionManager isAccelerometerAvailable] == YES){
      accelerometerAvailability = @"is";
    }
    
    NSLog(@"Accelerometer %@ available", 
          accelerometerAvailability);
    
    NSString *accelerometerIsOrIsNotActive = @"is not";
    
    if ([motionManager isAccelerometerActive] == YES){
      accelerometerIsOrIsNotActive = @"is";
    }
    
    NSLog(@"Accelerometer %@ active", 
          accelerometerIsOrIsNotActive);
    
  }
  
  return(self);
  
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  
  self.myButton = nil;
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (NO);
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
