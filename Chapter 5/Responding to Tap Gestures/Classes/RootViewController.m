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

@synthesize tapGestureRecognizer;

/* -------------------------- */

- (void) handleTaps:(UITapGestureRecognizer*)paramSender{
  
  NSUInteger touchCounter = 0;
  
  for (touchCounter = 0;
       touchCounter < paramSender.numberOfTouchesRequired;
       touchCounter++){
    
    CGPoint touchPoint = 
    [paramSender locationOfTouch:touchCounter 
                          inView:paramSender.view];
    
    NSLog(@"Touch #%lu: %@", 
          (unsigned long)touchCounter+1,
          NSStringFromCGPoint(touchPoint));
    
  }
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create the Tap Gesture Recognizer */
  UITapGestureRecognizer *newTapGestureRecognizer = 
  [[UITapGestureRecognizer alloc] 
   initWithTarget:self
   action:@selector(handleTaps:)];
  
  self.tapGestureRecognizer = newTapGestureRecognizer;
  
  [newTapGestureRecognizer release];
  
  /* The number of fingers that must be on the screen */
  self.tapGestureRecognizer.numberOfTouchesRequired = 2;
  
  /* The total number of taps to be performed before the 
   gesture is recognized */
  self.tapGestureRecognizer.numberOfTapsRequired = 3;
  
  /* Add this gesture recognizer to our view */
  [self.view addGestureRecognizer:self.tapGestureRecognizer];
  
  /* Get rid of the navigation bar for now as we don't need it */
  self.navigationController.navigationBarHidden = YES;
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.tapGestureRecognizer = nil;
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [tapGestureRecognizer release];
  [super dealloc];
}

/* -------------------------- */

@end
