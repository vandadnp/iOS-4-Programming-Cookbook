    //
//  RootViewController.m
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

/* --------------------------------------------- */

@implementation RootViewController

/* --------------------------------------------- */

@synthesize panGestureRecognizer, helloWorldLabel;

/* --------------------------------------------- */

- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender{
  
  if (paramSender.state != UIGestureRecognizerStateEnded &&
      paramSender.state != UIGestureRecognizerStateFailed){
    
    CGPoint location = [paramSender locationInView:paramSender.view.superview];
    paramSender.view.center = location;
    
  }
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Let's first create a label */
  CGRect labelFrame = CGRectMake(0.0f,    /* X */
                                 0.0f,    /* Y */
                                 150.0f,  /* Width */
                                 100.0f); /* Height */
  
  UILabel *newLabel = [[UILabel alloc] initWithFrame:labelFrame];
  
  self.helloWorldLabel = newLabel;
  [newLabel release];
  
  self.helloWorldLabel.text = @"Hello World";
  /* Contrasting colors to catch more attention */
  self.helloWorldLabel.backgroundColor = [UIColor blackColor];
  self.helloWorldLabel.textColor = [UIColor whiteColor];
  /* Center align the text to make it look better */
  self.helloWorldLabel.textAlignment = UITextAlignmentCenter;
  /* Make sure to enable user interaction; otherwise, tap events
   won't be caught on this label */
  self.helloWorldLabel.userInteractionEnabled = YES;
  /* And now make sure this label gets displayed on our view */
  [self.view addSubview:self.helloWorldLabel];
  
  /* --------- */
  
  /* Create the Pan Gesture Recognizer */
  UIPanGestureRecognizer *newPanGestureRecognizer = 
  [[UIPanGestureRecognizer alloc] 
   initWithTarget:self
   action:@selector(handlePanGestures:)];
  
  self.panGestureRecognizer = newPanGestureRecognizer;
  
  [newPanGestureRecognizer release];
  
  /* At least and at most we need only one finger to activate
   the pan gesture recognizer */
  self.panGestureRecognizer.minimumNumberOfTouches = 1;
  self.panGestureRecognizer.maximumNumberOfTouches = 1;
  
  /* Add it to our view */
  [self.helloWorldLabel addGestureRecognizer:self.panGestureRecognizer];
  
  /* Get rid of the navigation bar for now as we don't need it */
  self.navigationController.navigationBarHidden = YES;
  
}

/* --------------------------------------------- */

- (void) viewDidUnload{
  
  [super viewDidUnload];
  
  self.panGestureRecognizer = nil;
  self.helloWorldLabel = nil;
  
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  
  [panGestureRecognizer release];
  [helloWorldLabel release];
    
  [super dealloc];
}

/* --------------------------------------------- */

@end
