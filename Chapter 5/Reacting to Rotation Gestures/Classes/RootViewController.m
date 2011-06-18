    //
//  RootViewController.m
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* -------------------------- */

@implementation RootViewController

/* -------------------------- */

@synthesize rotationGestureRecognizer;
@synthesize helloWorldLabel;
@synthesize rotationAngleInRadians;

/* -------------------------- */

- (void) handleRotations:(UIRotationGestureRecognizer *)paramSender{
  
  if (self.helloWorldLabel == nil){
    return;
  }
  
  /* Take the previous rotation and add the current rotation to it */
  self.helloWorldLabel.transform = 
  CGAffineTransformMakeRotation(self.rotationAngleInRadians +
                                paramSender.rotation);
  
  /* At the end of the rotation, keep the angle for later use */
  if (paramSender.state == UIGestureRecognizerStateEnded){
    self.rotationAngleInRadians += paramSender.rotation;
  }
    
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create the gesture recognizer */
  UIRotationGestureRecognizer *rotationRecognizer = 
  [[UIRotationGestureRecognizer alloc] 
   initWithTarget:self
   action:@selector(handleRotations:)];
  
  self.rotationGestureRecognizer = rotationRecognizer;
  
  [rotationRecognizer release];
  
  /* Add it to our view */
  [self.view addGestureRecognizer:self.rotationGestureRecognizer];
    
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.helloWorldLabel = nil;
  self.rotationGestureRecognizer = nil;
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  
  [rotationGestureRecognizer release];
  [helloWorldLabel release];
  
  [super dealloc];
}

/* -------------------------- */

@end
