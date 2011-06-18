//
//  RootViewController_iPhone.m
//  Graphics
//
//  Created by Vandad Nahavandipoor on 10-07-31.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController_iPhone.h"
#import "SecondViewController.h"

/* --------------------------------- */

@implementation RootViewController_iPhone

/* --------------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
  }
  
  return(self);
  
}

/* --------------------------------- */

- (IBAction) performTakeScreenShot:(id)paramSender{
  
  /* Create a new bitmap context. This context becomes the 
   current graphics context */
  UIGraphicsBeginImageContext(self.view.bounds.size);
  
  /* Retrieve the handle to the new context that we created */
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  /* Render the contents of the view of this View Controller
   into the context we created */
  [self.view.layer renderInContext:context];
  
  /* Construct an image out of the current context's contents. */
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  /* Now push a new View Controller into the stack where 
   we will display the image to the user */
  SecondViewController *controller = 
  [[SecondViewController alloc] 
   initWithNibName:@"SecondViewController"
   bundle:nil];
  
  [self.navigationController pushViewController:controller
                                       animated:YES];
  
  /* Set the image inside the image view of the second
   View Controller so that the user can see the screen shot */
  controller.imageViewShot.image = image;
  
  [controller release];
  
}

/* --------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
 return (YES);
}

/* --------------------------------- */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

/* --------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];
}

/* --------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* --------------------------------- */

@end
