//
//  ViewsAndVCAppDelegate.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-08.
//  Copyright  2010. All rights reserved.
//

#import "ViewsAndVCAppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"

/* -------------------------- */

@implementation ViewsAndVCAppDelegate

/* -------------------------- */

@synthesize window;
@synthesize splitViewController;
@synthesize rightViewController;
@synthesize leftViewController;

/* -------------------------- */

- (void)splitViewController:(UISplitViewController*)svc
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
  
  [self.rightViewController.navigationItem 
   setLeftBarButtonItem:nil
   animated:YES];
  
}

/* -------------------------- */

- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc{
  
  barButtonItem.title = NSLocalizedString(@"Left Item", nil);
  
  [self.rightViewController.navigationItem 
   setLeftBarButtonItem:barButtonItem
   animated:YES];
  
}

/* -------------------------- */

- (BOOL) isiPad{
  
  BOOL result = NO;
  
  NSString *classAsString = 
  NSStringFromClass([UISplitViewController class]);
  
  if (classAsString == nil ||
      [classAsString length] == 0){
    return(NO);
  }
  
  UIDevice *device = [UIDevice currentDevice];
  
  if ([device respondsToSelector:
       @selector(userInterfaceIdiom)] == NO){
    return(NO);
  }
  
  if ([device userInterfaceIdiom] != UIUserInterfaceIdiomPad){
    return(NO);
  }
  
  /* Do extra checking based on screen size 
   for instance if you want */
  result = YES;
  
  return(result);
  
}

/* -------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
  
  /* First make sure this is an iPad running this application */
  
  if ([self isiPad] == YES){
    /* Create the View Controller that is shown on the left side */
    LeftViewController *leftVC = 
    [[LeftViewController alloc]
     initWithNibName:@"LeftViewController" 
     bundle:nil];
    
    self.leftViewController = leftVC;
    
    /* Create a Navigation Controller for
     the View Controller on the left */
    UINavigationController *leftNC = 
    [[UINavigationController alloc] 
     initWithRootViewController:leftVC];
    
    [leftVC release];
    
    /* Create the right-side View Controller now */
    RightViewController *rightVC = 
    [[RightViewController alloc] 
     initWithNibName:@"RightViewController" 
     bundle:nil];
    
    self.rightViewController = rightVC;
    
    leftVC.delegate = rightVC;
    
    /* And a Navigation Controller for the 
     View Controller on the right */
    UINavigationController *rightNC = 
    [[UINavigationController alloc]
     initWithRootViewController:rightVC];
    
    [rightVC release];
    
    /* Put all the Navigation Controllers in one array to 
     be passed to the Split Ciew Controller */
    NSArray *navigationControllers = 
      [NSArray arrayWithObjects:leftNC, rightNC, nil];
    
    [leftNC release];
    [rightNC release];
    
    /* Create the Split View Controller now. */
    UISplitViewController *splitController = 
    [[UISplitViewController alloc] init];
    
    self.splitViewController = splitController;
    self.splitViewController.delegate = self;
    [splitController release];
    
    /* Place the Navigation Controllers 
     (which are linked to our View Controllers),
     into the Split View Controller */
    [self.splitViewController 
     setViewControllers:navigationControllers];
    
    /* Show the View of the Split View Controller which is
     now the mixture of the left and right View Controllers */
    [window addSubview:self.splitViewController.view];
  } else {
    /* Choose another interface path if the device is not an iPad */
  }
  
  [window makeKeyAndVisible];
  
  return YES;
}

/* -------------------------- */

- (void)dealloc {
  [splitViewController release];
  [window release];
  [super dealloc];
}

/* -------------------------- */

@end
