    //
//  RootViewController.m
//  Swipes
//
//  Created by Vandad Nahavandipoor on 10-05-20.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

/* --------------------------------------------- */

@implementation RootViewController

/* --------------------------------------------- */

@synthesize swipeGestureRecognizer;

- (IBAction) doThis:(id)paramSender{
  SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController"
                                                                          bundle:nil];
  
  [self.navigationController pushViewController:secondVC
                                       animated:YES];
  
  [secondVC release];
}

/* --------------------------------------------- */

- (void) handleSwipes:(UISwipeGestureRecognizer *)paramSender{
  
  if (paramSender.direction & UISwipeGestureRecognizerDirectionDown){
    NSLog(@"Swiped Down.");
  }
  if (paramSender.direction & UISwipeGestureRecognizerDirectionLeft){
    NSLog(@"Swiped Left.");
  }
  if (paramSender.direction & UISwipeGestureRecognizerDirectionRight){
    NSLog(@"Swiped Right.");
  }
  if (paramSender.direction & UISwipeGestureRecognizerDirectionUp){
    NSLog(@"Swiped Up.");
  }
  
}

/* --------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Instantiate our object */
  UISwipeGestureRecognizer *newSwipeRecognizer = 
  [[UISwipeGestureRecognizer alloc] 
   initWithTarget:self 
   action:@selector(handleSwipes:)];
  
  self.swipeGestureRecognizer = newSwipeRecognizer;
  
  [newSwipeRecognizer release];
    
  /* Swipes that are performed from right to 
   left are to be detected */
  self.swipeGestureRecognizer.direction = 
  UISwipeGestureRecognizerDirectionLeft;
  
  /* Just one finger needed */
  self.swipeGestureRecognizer.numberOfTouchesRequired = 1;
  
  /* Add it to the view */
  [self.view addGestureRecognizer:self.swipeGestureRecognizer];
  
}

/* --------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.swipeGestureRecognizer = nil;
  
}

/* --------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* --------------------------------------------- */

- (void)dealloc {
  [swipeGestureRecognizer release];
  [super dealloc];
}

/* --------------------------------------------- */

@end
