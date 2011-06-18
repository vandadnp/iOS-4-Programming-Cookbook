//
//  RootViewController.m
//  Threads
//
//  Created by Vandad Nahavandipoor on 10-07-04.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "MyObject.h"

@implementation RootViewController

@synthesize newThread;

/* -------------------------- */

- (void) newThreadEntryPoint{
  
  /* A thread without an autorelease pool to test the below code */
  
  //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  
  /* This WILL cause a memory leak */
  [self performSelector:@selector(allocateSomething)];
  
  /* This will NOT cause a memory leak */
  [self performSelectorOnMainThread:@selector(allocateSomething)
                         withObject:nil
                      waitUntilDone:YES];
  
  //[pool release];
  
}

/* -------------------------- */

- (void) allocateSomething{
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSString *imagePath = [mainBundle pathForResource:@"MyImage"
                                             ofType:@"png"];
  
  NSData    *imageData = [NSData dataWithContentsOfFile:imagePath];
  
  UIImage  *myImage = [[[UIImage alloc] initWithData:imageData] autorelease];
  
  /* Do something with the image here */
  NSLog(@"Image = %@", myImage);

}


/* -------------------------- */

- (void)viewDidLoad {
  
  
  [NSThread detachNewThreadSelector:@selector(newThreadEntryPoint)
                           toTarget:self
                         withObject:nil];
  
}

/* -------------------------- */

//- (void) myThread:(id)paramObject{
//  
//  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//  
//  while ([[NSThread currentThread] isCancelled] == NO){
//    
//    [NSThread sleepForTimeInterval:0.20f];
//    
//    if ([[NSThread currentThread] isCancelled] == NO){
//      MyObject *Object = [[[MyObject alloc] init] autorelease];
//      [Object doSomething];
//    }
//    
//  }
//  
//  [pool release];
//  
//}

/* -------------------------- */

//- (void) myThread:(id)paramObject{
//  
//  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//  
//  while ([[NSThread currentThread] isCancelled] == NO){
//    
//    NSAutoreleasePool *insidePool = [[NSAutoreleasePool alloc] init];
//    
//    [NSThread sleepForTimeInterval:0.20f];
//    
//    if ([[NSThread currentThread] isCancelled] == NO){
//      MyObject *Object = [[[MyObject alloc] init] autorelease];
//      [Object doSomething];
//    }
//    
//    [insidePool release];
//    
//  }
//  
//  [pool release];
//  
//}

/* -------------------------- */

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/* -------------------------- */

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
