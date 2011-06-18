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
    self.title = NSLocalizedString(@"First View Controller", nil);
  }
  
  return(self);
  
}

/* -------------------------- */

- (void) goToSecondViewController{
  
  SecondViewController *controller = 
  [[SecondViewController alloc] 
   initWithNibName:@"SecondViewController"
   bundle:nil];
  
  [self.navigationController pushViewController:controller
                                       animated:YES];
  
  [controller release];
  
}

/* -------------------------- */

- (void) viewDidLoad{
  [super viewDidLoad];
  
  /* Show the second View Controller 3 seconds
   after this View Controller's
   view is loaded */
  
  [self performSelector:@selector(goToSecondViewController)
             withObject:nil
             afterDelay:3.0f];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  [NSObject 
   cancelPreviousPerformRequestsWithTarget:self
    selector:@selector(goToSecondViewController)
      object:nil];
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation
  :(UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* -------------------------- */

@end
