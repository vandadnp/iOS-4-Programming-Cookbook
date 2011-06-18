//
//  SecondViewController.m
//  Graphics
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

/* --------------------------------- */

@synthesize imageViewShot;

/* --------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    // Custom initialization
  }
  return self;
}

/* --------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
}

/* --------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* --------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

/* --------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
  self.imageViewShot = nil;
}
/* --------------------------------- */

- (void)dealloc {
  [imageViewShot release];
  [super dealloc];
}

/* --------------------------------- */

@end
