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

@synthesize pinchGestureRecognizer;
@synthesize myBlackLabel;
@synthesize currentScale;

/* -------------------------- */

- (void) handlePinches:(UIPinchGestureRecognizer*)paramSender{
  
  if (paramSender.state == UIGestureRecognizerStateEnded){
    self.currentScale = paramSender.scale;
  } else if (paramSender.state == UIGestureRecognizerStateBegan &&
             self.currentScale != 0.0f){
    paramSender.scale = self.currentScale;
  }
  
  if (paramSender.scale != NAN &&
      paramSender.scale != 0.0){
    paramSender.view.transform = 
      CGAffineTransformMakeScale(paramSender.scale, 
                                 paramSender.scale);
  }
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGRect labelRect = CGRectMake(0.0f,     /* X */
                                0.0f,     /* Y */
                                200.0f,   /* Width */
                                200.0f);  /* Height */
  
  UILabel *newLabel = 
  [[UILabel alloc] initWithFrame:labelRect];
  
  self.myBlackLabel = newLabel;
  
  [newLabel release];
  
  /* Put the label in the center of the view */
  self.myBlackLabel.center = self.view.center;
  
  /* The black color, of course */
  self.myBlackLabel.backgroundColor = [UIColor blackColor];
  
  /* Without this line, our pinch gesture recognizer
   will not work */
  self.myBlackLabel.userInteractionEnabled = YES;
  
  /* Add this label to our view */
  [self.view addSubview:self.myBlackLabel];
  
  /* Create the Pinch Gesture Recognizer */
  self.pinchGestureRecognizer = 
    [[UIPinchGestureRecognizer alloc] 
      initWithTarget:self
              action:@selector(handlePinches:)];
  
  /* Add this gesture recognizer to our view */
  [self.myBlackLabel 
   addGestureRecognizer:self.pinchGestureRecognizer];
    
  /* Get rid of the navigation bar for now as we don't need it */
  self.navigationController.navigationBarHidden = YES;
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.myBlackLabel = nil;
  self.pinchGestureRecognizer = nil;
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [pinchGestureRecognizer release];
  [myBlackLabel release];
  [super dealloc];
}

/* -------------------------- */

@end
