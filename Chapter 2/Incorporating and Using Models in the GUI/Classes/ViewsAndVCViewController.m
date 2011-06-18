//
//  ViewsAndVCViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import "ViewsAndVCViewController.h"
#import "ViewsAndVCAppDelegate.h"
#import "MyWorld.h"

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

- (void)viewDidLoad {
  [super viewDidLoad];
  
  MyWorld *bigWorld = [MyWorld sharedInstance];
  MyWorld *theSameWorld = [MyWorld sharedInstance];
  
  if ([bigWorld isEqual:theSameWorld] == YES){
    NSLog(@"The Big World and the Same World are the same!");
  } else {
    NSLog(@"These two worlds are different.");
  }

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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
