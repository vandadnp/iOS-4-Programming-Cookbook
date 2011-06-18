    //
//  AddNewViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-10-15.
//  Copyright 2010  All rights reserved.
//

#import "AddNewViewController.h"

/* --------------------- */

@implementation AddNewViewController

/* --------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.modalInPopover = YES;
  self.contentSizeForViewInPopover = CGSizeMake(200.0f,
                                                168.0f);
}

/* --------------------- */

- (void) viewDidAppear:(BOOL)bla{
  [super viewDidAppear:bla];
  
}

@end
