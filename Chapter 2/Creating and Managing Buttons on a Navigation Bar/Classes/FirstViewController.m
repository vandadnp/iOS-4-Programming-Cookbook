//
//  FirstViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright 2010  All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

/* -------------------------- */

@implementation FirstViewController

/* -------------------------- */

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    self.title = NSLocalizedString(@"Buttons Everywhere", nil);
  }
  
  return(self);
  
}

/* -------------------------- */

- (void) performLeft:(id)paramSender{
  /* Peform an action here */
}

/* -------------------------- */

- (void) performRight:(id)paramSender{
  /* Perform another action here */
}

/* -------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  /* Create the button that appears on the Right Side */
//  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
//                                  initWithTitle:@"Right"
//                                  style:UIBarButtonItemStylePlain
//                                  target:self
//                                  action:@selector(performRight:)];
//  
//  /* Create the button that appears on the Left Side */
//  UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
//                                 initWithTitle:@"Left"
//                                 style:UIBarButtonItemStyleDone
//                                 target:self
//                                 action:@selector(performLeft:)];
//  
//  /* Assign the buttons to the Navigation Item's properties */
//  self.navigationItem.rightBarButtonItem = rightButton;
//  self.navigationItem.leftBarButtonItem = leftButton;
//  
//  [rightButton release];
//  [leftButton release];
//}

/* -------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  UIBarButtonItem *rightButton = 
//  [[UIBarButtonItem alloc]
//   initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
//   target:self
//   action:@selector(performRight:)];
//  
//  UIBarButtonItem *leftButton = 
//  [[UIBarButtonItem alloc]
//   initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
//   target:self
//   action:@selector(performLeft:)];
//  
//  [self.navigationItem setRightBarButtonItem:rightButton
//                                    animated:YES];
//  
//  [self.navigationItem setLeftBarButtonItem:leftButton
//                                   animated:YES];
//  
//  /* Release the buttons */
//  [rightButton release];
//  [leftButton release];
//  
//}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSArray *items = [NSArray arrayWithObjects:@"Up", @"Down", nil];
  
  UISegmentedControl *segmentedButton = 
  [[UISegmentedControl alloc] 
    initWithItems:items];
  
  /* Make the buttons on not stay on when they are tapped */
  segmentedButton.momentary = YES;
  
  [segmentedButton setSegmentedControlStyle:UISegmentedControlStyleBar];
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] 
                                  initWithCustomView:segmentedButton];
  
  [self.navigationItem setRightBarButtonItem:rightButton
                                    animated:YES];
  
  [rightButton release];
  [segmentedButton release];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.navigationItem.rightBarButtonItem = nil;
  self.navigationItem.leftBarButtonItem = nil;
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* -------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* -------------------------- */


@end
