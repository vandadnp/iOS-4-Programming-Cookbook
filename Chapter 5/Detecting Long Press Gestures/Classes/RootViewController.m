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

@synthesize longPressGestureRecognizer;
@synthesize dummyButton;

/* -------------------------- */

- (void) handleLongPressGestures:(UILongPressGestureRecognizer*)paramSender{
  
  /* Here we want to find the mid point of the two fingers
   that caused the long press gesture to be recognized. We configured
   this number using the numberOfTouchesRequired property of the
   UILongPressGestureRecognizer that we instantiated in the
   viewDidLoad instance method of this View Controller. If we
   find that another long press gesture recognizer is using this
   method as its target, we will ignore it */
  
  if ([paramSender isEqual:self.longPressGestureRecognizer] == YES){
    
    if (paramSender.numberOfTouchesRequired == 2){
      
      CGPoint touchPoint1 = 
      [paramSender locationOfTouch:0
                            inView:paramSender.view];
      
      CGPoint touchPoint2 = 
      [paramSender locationOfTouch:1
                            inView:paramSender.view];
      
      CGFloat midPointX = (touchPoint1.x + touchPoint2.x) / 2.0f;
      CGFloat midPointY = (touchPoint1.y + touchPoint2.y) / 2.0f;
      
      CGPoint midPoint = CGPointMake(midPointX, midPointY);
      
      self.dummyButton.center = midPoint;
      
    } else {
      
      /* This is a long press gesture recognizer with more 
       or less than 2 fingers */
      
    }
    
  }

}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* First create the gesture recognizer */
  UILongPressGestureRecognizer *newLongPressGestureRecognizer = 
  [[UILongPressGestureRecognizer alloc] 
   initWithTarget:self
   action:@selector(handleLongPressGestures:)];
  
  self.longPressGestureRecognizer = newLongPressGestureRecognizer;
  [newLongPressGestureRecognizer release];
    
  /* The number of fingers that must be present on the screen */
  self.longPressGestureRecognizer.numberOfTouchesRequired = 2;
  
  /* Maximum 100 pixels of movement allowed before the gesture
   is recognized */
  self.longPressGestureRecognizer.allowableMovement = 100.0f;
  
  /* The user must press 2 fingers (numberOfTouchesRequired) for
   at least 1 second for the gesture to be recognized */
  self.longPressGestureRecognizer.minimumPressDuration = 1.0;
  
  /* Add this gesture recognizer to our view */
  [self.view addGestureRecognizer:self.longPressGestureRecognizer];
  
  /* Get rid of the navigation bar for now as we don't need it */
  self.navigationController.navigationBarHidden = YES;
  
}

/* -------------------------- */

- (void) viewDidUnload{  
  [super viewDidUnload];
  
  self.longPressGestureRecognizer = nil;
  self.dummyButton = nil;
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [longPressGestureRecognizer release];
  [dummyButton release];
  [super dealloc];
}

/* -------------------------- */

@end
