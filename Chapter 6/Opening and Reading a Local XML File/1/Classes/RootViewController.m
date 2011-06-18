//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize myXMLParser;

/* -------------------------- */

- (void)                parser:(NSXMLParser *)parser 
               didStartElement:(NSString *)elementName 
                  namespaceURI:(NSString *)namespaceURI
                 qualifiedName:(NSString *)qName
                    attributes:(NSDictionary *)attributeDict{
  
  NSLog(@"Element Name = %@", elementName);
  
  NSLog(@"Number of attributes = %lu", 
        (unsigned long)[attributeDict count]);
  
  if ([attributeDict count] > 0){
    NSLog(@"Attributes dictionary = %@", attributeDict);
  }
  
  NSLog(@"========================");
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSBundle *mainBundle = [NSBundle mainBundle];
  
  /* Let's get the path of the XML file in the app bundle */
  NSString *xmlFilePath = [mainBundle pathForResource:@"MyXML"
                                               ofType:@"xml"];
  
  if ([xmlFilePath length] == 0){
    /* The file could not be found in the resources folder.
     Do something appropriate here */
    return;
  }
  
  /* Let's see if the XML file exists... */
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  
  if ([fileManager fileExistsAtPath:xmlFilePath] == NO){
    /* The XML file doesn't exist, we double checked this just
     to make sure we don't leave any stones unturned. You can now
     throw an error/exception here or do other appropriate processing */
    NSLog(@"The file doesn't exist.");
    [fileManager release];
    return;
  }
  
  [fileManager release];
  
  /* Load the contents of the XML file into an NSData */
  NSData *xmlData = [NSData dataWithContentsOfFile:xmlFilePath];
  
  NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
  self.myXMLParser = xmlParser;
  [xmlParser release];
  
  [self.myXMLParser setDelegate:self];
  
  if ([self.myXMLParser parse] == YES){
    /* Successfully started to parse */
  } else {
    /* Failed to parse. Do something with this error */
    NSError *parsingError = [self.myXMLParser parserError];
    NSLog(@"%@", parsingError);
  }
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.myXMLParser = nil;
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  
  [myXMLParser release];
  [super dealloc];
}

/* -------------------------- */

@end
