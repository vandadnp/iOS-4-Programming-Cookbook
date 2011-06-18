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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/* -------------------------- */

- (UIWindow *) delegateWindow{
  
  UIWindow *result = nil;
  
  ViewsAndVCAppDelegate *delegate = 
    (ViewsAndVCAppDelegate *)[[UIApplication sharedApplication] delegate];
  
  if (delegate != nil){
    result = [delegate window];
  }
  
  return(result);
  
}

/* -------------------------- */

- (void) logMainWindowRect{
  
  UIWindow *mainWindow = [self delegateWindow];
  
  if (mainWindow != nil){
    
    NSLog(@"Window Rect = %@", NSStringFromCGRect(mainWindow.frame));
    
  }
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self logMainWindowRect];
  
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
