//
//  FirstViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-18.
//  Copyright 2010  All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

/* -------------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
      self.title = @"First";
    }
    return self;
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImage *TabImage = [UIImage imageNamed:@"FirstTabImage.png"];
  self.tabBarItem.image = TabImage;
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.tabBarItem.image = nil;
}

/* -------------------------- */

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
