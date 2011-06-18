//
//  RootViewController.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-07-04.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize myThread;

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
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSString *fileURL = (NSString *)paramObject;
  
  NSURL    *url = [NSURL URLWithString:fileURL];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  NSURLResponse *response = nil;
  NSError       *error = nil;
  
  NSData *downloadedData = 
  [NSURLConnection sendSynchronousRequest:request
                        returningResponse:&response
                                    error:&error];
  
  if ([downloadedData length] > 0){
    /* Fully downloaded */
  } else {
    /* Nothing was downloaded. Check the Error value */
  }
  
  [pool release];
  
}

/* -------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  NSString *fileToDownload = @"http://www.OReilly.com";
//  
//  [NSThread detachNewThreadSelector:@selector(downloadNewFile:) 
//                           toTarget:self 
//                         withObject:fileToDownload];
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
  
  NSUInteger counter = 0;
  for (counter = 0;
       counter < 1000;
       counter++){
    NSLog(@"Third Counter = %lu", (unsigned long)counter);
  }
  
}

/* -------------------------- */

//- (void)viewDidLoad {
//  
//  [super viewDidLoad];
//  
//  [NSThread detachNewThreadSelector:@selector(firstCounter)
//                           toTarget:self
//                         withObject:nil];
//  
//  
//  [NSThread detachNewThreadSelector:@selector(secondCounter)
//                           toTarget:self
//                         withObject:nil];
//  
//  /* Run this on the main thread */
//  [self thirdCounter];
//  
//}

/* -------------------------- */

//- (void) autoreleaseThread:(id)paramSender{
//  
//  NSBundle *mainBundle = [NSBundle mainBundle];
//  NSString *filePath = [mainBundle pathForResource:@"Default"
//                                            ofType:@"png"];
//  
//  UIImage *image = [[[UIImage alloc] 
//                     initWithContentsOfFile:filePath]
//                    autorelease];
//  
//  /* Do something with the image */
//  NSLog(@"Image = %@", image);
//  
//}

/* -------------------------- */

- (void) autoreleaseThread:(id)paramSender{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  NSString *filePath = [mainBundle pathForResource:@"Default"
                                            ofType:@"png"];
  
  UIImage *image = [[[UIImage alloc] 
                     initWithContentsOfFile:filePath]
                    autorelease];
  
  /* Do something with the image */
  NSLog(@"Image = %@", image);
  
  [pool release];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [NSThread detachNewThreadSelector:@selector(autoreleaseThread:)
                           toTarget:self
                         withObject:self];
  
}

/* -------------------------- */

//- (void)viewDidLoad {
//  
//  [super viewDidLoad];
//  
//  NSThread *newThread = 
//  [[NSThread alloc] initWithTarget:self
//                          selector:@selector(autoreleaseThread:)
//                            object:self];
//  
//  [newThread start];
//  self.myThread = newThread;
//  [newThread release];
//  
//  
//}

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
