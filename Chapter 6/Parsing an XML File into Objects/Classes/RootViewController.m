//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "XMLDocument.h"
#import "XMLElement.h"

@implementation RootViewController

/* -------------------------- */

- (void) recursivelyLogXMLContents:(XMLElement*)paramElement{
  
  NSLog(@"Element Name = %@", paramElement.name);
  
  NSLog(@"Element Text = %@", paramElement.text);
  
  NSLog(@"Number of Attributes = %lu", 
        (unsigned long)[paramElement.attributes count]);
  
  if (paramElement.parent != nil){
    NSLog(@"Parent Element Name = %@", paramElement.parent.name);
  }
  
  if ([paramElement.attributes count]){
    NSLog(@"Attributes Dictionary = %@", paramElement.attributes);
  }
  
  NSLog(@"Number of children elements = %lu", 
        (unsigned long)[paramElement.children count]);
  
  for (XMLElement *child in paramElement.children){
    [self recursivelyLogXMLContents:child];
  }
    
}


/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  NSString *xmlFilePath = [mainBundle pathForResource:@"MyXML"
                                               ofType:@"xml"];
  
  XMLDocument     *document = [[XMLDocument alloc] init];
  
  if ([document parseLocalXMLWithPath:xmlFilePath] == YES){
    [self recursivelyLogXMLContents:document.rootElement];
  } else {
    NSLog(@"Could not parse the XML file.");
  }
  
  [document release];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  
  
  [super dealloc];
}

/* -------------------------- */

@end
