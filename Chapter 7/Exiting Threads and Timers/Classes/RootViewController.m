//
//  RootViewController.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-07-04.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

/* -------------------------- */

@implementation RootViewController

/* -------------------------- */

@synthesize myThread;
@synthesize myTimer;

/* -------------------------- */

- (void) threadEntryPoint{
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  NSLog(@"Thread Entry Point");
  
  while ([[NSThread currentThread] isCancelled] == NO){
    
    [NSThread sleepForTimeInterval:0.2];
    
    if ([[NSThread currentThread] isCancelled] == NO){
      NSLog(@"Thread Loop");
    }
    
  }
  
  NSLog(@"Thread Finished");
  
  [pool release];
  
}

/* -------------------------- */

- (void) stopThread{
  NSLog(@"Cancelling the Thread");
  [self.myThread cancel];
  NSLog(@"Releasing the thread");
  self.myThread = nil;
}

/* -------------------------- */

- (void)viewDidLoad {
  
  NSThread *newThread = [[NSThread alloc] 
                         initWithTarget:self
                         selector:@selector(threadEntryPoint)
                         object:nil];
  self.myThread = newThread;
  [newThread release];
  
  [self performSelector:@selector(stopThread)
             withObject:nil
             afterDelay:3.0f];
  
  [self.myThread start];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.myThread = nil;
}

/* -------------------------- */

- (void) timerEntryPoint:(NSTimer *)paramSender{
  
  NSLog(@"Timer Entry Point");
  
}


//self.myTimer = [NSTimer scheduledTimerWithTimeInterval:4.0f
//                                                   target:self
//                                                 selector:@selector(timerEntryPoint:)
//                                                 userInfo:nil
//                                                  repeats:YES];

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
  [myTimer release];
  [myThread release];
    [super dealloc];
}


@end
