//
//  RootViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-10-15.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "AddNewViewController.h"

/* --------------------- */

@implementation RootViewController

/* --------------------- */

@synthesize barButtonAdd;
@synthesize popoverController;

/* --------------------- */

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil {
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    self.title = @"Scrap Book";
    
    /* Allocate and initialize the add button first */
    UIBarButtonItem *newAddButton = 
    [[UIBarButtonItem alloc] 
     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(addNew:)];
    
    barButtonAdd = [newAddButton retain];
    [newAddButton release];
    
    /* This will be the View Controller that will get
     displayed in the Popover Controller */
    AddNewViewController *addNewViewController = 
    [[AddNewViewController alloc] 
     initWithNibName:@"AddNewViewController"
     bundle:nil];
    
    /* Create the popover using the View Controller */
    UIPopoverController *newPopoverController = 
    [[UIPopoverController alloc]
     initWithContentViewController:addNewViewController];
    
    [addNewViewController release];
    
    popoverController = [newPopoverController retain];
    
    [newPopoverController release];
    
  }
  return self;
}

/* --------------------- */

- (void) viewDidLoad{
  [super viewDidLoad];
  
  /* Put the Add button on the navigation bar */
  [self.navigationItem 
   setRightBarButtonItem:self.barButtonAdd
   animated:YES];
  
}

/* --------------------- */

- (void) addNew:(id)paramSender{
  
  if (self.popoverController.popoverVisible == YES){
    
    [self.popoverController dismissPopoverAnimated:YES];
    
  } else {
    
    [self.popoverController 
     presentPopoverFromBarButtonItem:self.barButtonAdd
     permittedArrowDirections:UIPopoverArrowDirectionUp
     animated:YES];
    
  }
  
}

/* --------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
        (UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* --------------------- */

- (void)dealloc {
  [barButtonAdd release];
  [popoverController release];
  [super dealloc];
}

/* --------------------- */

@end
