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
    
    CMMotionManager *newMotionManager = 
    [[CMMotionManager alloc] init];
    
    self.motionManager = newMotionManager;
    [newMotionManager release];
    
    NSString *gyroscropeAvailability = @"is not";
    
    if ([motionManager isGyroAvailable] == YES){
      gyroscropeAvailability = @"is";
    }
    
    NSLog(@"Gyroscope %@ available", 
          gyroscropeAvailability);
    
    NSString *gyroIsOrIsNotActive = @"is not";
    
    if ([motionManager isGyroActive] == YES){
      gyroIsOrIsNotActive = @"is";
    }
    
    NSLog(@"Gyroscope %@ active", 
          gyroIsOrIsNotActive);
    
    
  }
  return self;
}

/* ----------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
}

/* ----------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ----------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* ----------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
}

/* ----------------------------------- */

- (void)dealloc {
  [motionManager release];
  [super dealloc];
}

/* ----------------------------------- */

@end
