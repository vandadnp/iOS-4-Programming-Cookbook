//
//  FirstViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-10.
//  Copyright 2010  All rights reserved.
//

#import "FirstViewController.h"

/* -------------------------- */

@implementation FirstViewController

/* -------------------------- */

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
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

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create an Image View to replace the Title View */
  UIImageView *imageView = 
  [[UIImageView alloc] 
   initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
  
  /* Load an image. Be careful, this image will be cached */
  UIImage     *image = [UIImage imageNamed:@"FullSizeLogo.png"];
  
  /* Set the image of the Image View */
  [imageView setImage:image];
  
  /* Set the Title View */
  self.navigationItem.titleView = imageView;
  
  /* Release the image view now */
  [imageView release];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
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
