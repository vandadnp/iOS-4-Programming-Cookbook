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
  
  NSLog(@"Number of Attributes = %d", [paramElement.attributes count]);
  
  if (paramElement.parent != nil){
    NSLog(@"Parent Element Name = %@", paramElement.parent.name);
  }
  
  if ([paramElement.attributes count]){
    NSLog(@"Attributes Dictionary = %@", paramElement.attributes);
  }
  
  NSLog(@"Number of children elements = %d", [paramElement.children count]);
  
  if ([paramElement.children count] > 0){
    for (XMLElement *Child in paramElement.children){
      [self recursivelyLogXMLContents:Child];
    }
  }
  
}


/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSBundle *MainBundle = [NSBundle mainBundle];
  
  NSString *XMLFilePath = [MainBundle pathForResource:@"MyXML"
                                               ofType:@"xml"];
  
  if (XMLFilePath == nil ||
      [XMLFilePath length] == 0){
    /* The file could not be found in the resources folder.
     Do something appropriate here */
    return;
  }
  
  XMLDocument     *Document = [[XMLDocument alloc] init];
  
  if ([Document parseLocalXMLWithPath:XMLFilePath] == TRUE){
    [self recursivelyLogXMLContents:Document.rootElement];
  } else {
    NSLog(@"Could not parse the XML file.");
  }
  
  [Document release];
  Document = nil;
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (TRUE);
}

/* -------------------------- */

- (void)dealloc {
  
  
  [super dealloc];
}

/* -------------------------- */

@end
