//
//  RootViewController.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-07-04.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/* -------------------------- */

- (void) downloadNewFile:(id)paramObject{
  
  NSAutoreleasePool *Pool = [[NSAutoreleasePool alloc] init];
  
  NSString *FileURL = (NSString *)paramObject;
  
  NSURL    *URL = [NSURL URLWithString:FileURL];
  
  NSURLRequest *Request = [NSURLRequest requestWithURL:URL];
  
  NSURLResponse *Response = nil;
  NSError       *Error = nil;
  
  NSData *DownloadedData = [NSURLConnection sendSynchronousRequest:Request
                                                 returningResponse:&Response
                                                             error:&Error];
  
  if ([DownloadedData length] > 0){
    /* Fully downloaded */
  } else {
    /* Nothing was downloaded. Check the Error value */
  }
  
  [Pool release];
  
}

/* -------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  NSString *FileToDownload = @"http://www.OReilly.com";
//  
//  [NSThread detachNewThreadSelector:@selector(downloadNewFile:) 
//                           toTarget:self 
//                         withObject:FileToDownload];
//  
//  
//  
//  
//}

/* -------------------------- */

- (void) firstCounter{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSUInteger counter = 0;
  for (counter = 0;
       counter < 1000;
       counter++){
    NSLog(@"First Counter = %lu", (unsigned long)counter);
  }
  
  [pool release];
  
}

/* -------------------------- */

- (void) secondCounter{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSUInteger counter = 0;
  for (counter = 0;
       counter < 1000;
       counter++){
    NSLog(@"Second Counter = %lu", (unsigned long)counter);
  }
  
  [pool release];
  
}

/* -------------------------- */

- (void) thirdCounter{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSUInteger counter = 0;
  for (counter = 0;
       counter < 1000;
       counter++){
    NSLog(@"Third Counter = %lu", (unsigned long)counter);
  }
  
  [pool release];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self performSelectorInBackground:@selector(firstCounter)
                         withObject:nil];
  
  [self performSelectorInBackground:@selector(secondCounter)
                         withObject:nil];
  
  [self performSelectorInBackground:@selector(thirdCounter)
                         withObject:nil];
  
}

/* -------------------------- */

- (IBAction)      performButtonAction:(id)Sender{
  
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
