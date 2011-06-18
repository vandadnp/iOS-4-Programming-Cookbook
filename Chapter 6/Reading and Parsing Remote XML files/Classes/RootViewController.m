//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "XMLElement.h"

/* -------------------------- */

@implementation RootViewController

/* -------------------------- */

@synthesize xmlDocument;

/* -------------------------- */

- (void) xmlDocumentDelegateParsingFinished
         :(XMLDocument *)paramSender{
  
  NSLog(@"Finished downloading and parsing the remote XML");

}

/* -------------------------- */

- (void) xmlDocumentDelegateParsingFailed
          :(XMLDocument *)paramSender 
 withError:(NSError *)paramError{
  
  NSLog(@"Failed to download/parse the remote XML.");
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *xmlPath = @"THE URL OF AN XML FILE ON THE INTERNET";
  
  XMLDocument *newDocument = [[XMLDocument alloc] initWithDelegate:self];
  self.xmlDocument = newDocument;
  [newDocument release];
  
  [self.xmlDocument parseRemoteXMLWithURL:xmlPath];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];

  self.xmlDocument = nil;

}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  [xmlDocument release];
  [super dealloc];
}

/* -------------------------- */

@end