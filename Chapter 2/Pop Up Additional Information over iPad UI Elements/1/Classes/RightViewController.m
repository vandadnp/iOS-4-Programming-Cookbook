    //
//  RightViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-09.
//  Copyright 2010  All rights reserved.
//

#import "RightViewController.h"

@implementation RightViewController

/* --------------------- */

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    self.title = NSLocalizedString(@"Right View Controller", nil);
    
  }
  
  return(self);
  
}

/* --------------------- */

- (void) addNewItem:(id)paramSender{
  
  
  
}



/* --------------------- */

- (void)        leftViewController:(LeftViewController*)paramSender
   itemIsSelectedWithItemIndexPath:(NSIndexPath*)paramItemIndexPath
                          itemText:(NSString*)paramItemText{
  
  self.title = [NSString stringWithFormat:
                @"(%@) is selected on the left side", paramItemText];
  
}

/* --------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
    
}

/* --------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
}

/* --------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* --------------------- */

- (void)dealloc {
  [super dealloc];
}

@end
