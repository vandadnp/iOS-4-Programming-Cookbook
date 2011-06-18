//
//  SecondViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright 2010  All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

/* -------------------------- */

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    self.title = NSLocalizedString(@"Second View Controller", nil);
  }
  
  return(self);
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
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

