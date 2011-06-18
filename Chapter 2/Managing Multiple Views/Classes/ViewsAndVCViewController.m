//
//  ViewsAndVCViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import "ViewsAndVCViewController.h"
#import "ViewsAndVCAppDelegate.h"

@implementation ViewsAndVCViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/* -------------------------- */

- (void)loadView {
  
  [super loadView];
  
  UIView *myNewView = [[UIView alloc] init];
  
  CGRect currentViewFrame = self.view.frame;
  CGRect newViewFrame = CGRectMake(0.0f, 
                                   0.0f, 
                                   currentViewFrame.size.width / 2.0f, 
                                   currentViewFrame.size.height / 2.0f);
  
  myNewView.frame = newViewFrame;
  myNewView.backgroundColor = [UIColor blueColor];
  
  [self.view addSubview:myNewView];
  
  [myNewView release];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
}



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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
