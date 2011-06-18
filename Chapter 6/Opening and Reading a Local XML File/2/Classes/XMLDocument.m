//
//  XMLDocument.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import "XMLDocument.h"

@implementation XMLDocument

/* -------------------------- */

@synthesize documentPath;
@synthesize rootElement;
@synthesize xmlParser;
@synthesize currentElement;

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
       didStartElement:(NSString *)elementName
          namespaceURI:(NSString *)namespaceURI
         qualifiedName:(NSString *)qName
            attributes:(NSDictionary *)attributeDict{
  
  if (self.rootElement == nil){
    self.rootElement = [[XMLElement alloc] init];
    self.currentElement = self.rootElement;
  } else {
    XMLElement *NewElement = [[XMLElement alloc] init];
    NewElement.parent = self.currentElement;
    [self.currentElement.children addObject:NewElement];
    self.currentElement = NewElement;
    [NewElement release];
  }
  
  self.currentElement.name = elementName;
  
  if (attributeDict != nil &&
      [attributeDict count] > 0){
    [self.currentElement.attributes addEntriesFromDictionary:attributeDict];
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
       foundCharacters:(NSString *)string{
  
  if (self.currentElement != nil){
    self.currentElement.text = string;
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
         didEndElement:(NSString *)elementName 
          namespaceURI:(NSString *)namespaceURI 
         qualifiedName:(NSString *)qName{
  
  if (self.currentElement != nil){
    self.currentElement = self.currentElement.parent;
  }

}

/* -------------------------- */

- (BOOL) parseLocalXMLWithPath:(NSString*)localXMLPath{
   
  BOOL Result = FALSE;
  
  if (localXMLPath == nil ||
      [localXMLPath length] == 0){
    NSLog(@"The given XML path is nil or empty.");
    return(FALSE);
  }
  
  /* Does this file exist? */
  NSFileManager *FileManager = [NSFileManager defaultManager];
  
  if ([FileManager fileExistsAtPath:localXMLPath] == FALSE){
    NSLog(@"The given local path does not exist.");
    return(FALSE);
  }
  
  NSData *LocalXMLData = [NSData dataWithContentsOfFile:localXMLPath];
  
  if (LocalXMLData == nil){
    NSLog(@"The local XML file could not be loaded.");
    return(FALSE);
  }
  
  self.xmlParser = [[NSXMLParser alloc] initWithData:LocalXMLData];
  [self.xmlParser setDelegate:self];
  Result = [self.xmlParser parse];
  
  return(Result);
  
}

/* -------------------------- */

- (void) dealloc {
  
  if (self.xmlParser != nil){
    [self.xmlParser release];
  }
  
  if (self.rootElement != nil){
    [self.rootElement release];
  }
  
  if (self.documentPath != nil){
    [self.documentPath release];
  }
  
  [super dealloc];
}
/* -------------------------- */

@end
