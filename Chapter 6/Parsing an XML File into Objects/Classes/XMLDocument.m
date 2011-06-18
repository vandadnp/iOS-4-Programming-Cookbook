//
//  XMLDocument.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import "XMLDocument.h"
#import "XMLElement.h"

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
  
  /* Have we already created a root element? */
  if (self.rootElement == nil){
    
    /* We are here because the element we have found is the
     root element. So let's create the root element and set the
     current element to the root element for later user */
    
    XMLElement *root = [[XMLElement alloc] init];
    self.rootElement = root;
    self.currentElement = self.rootElement;
    [root release];
    
  } else {
    
    /* If we are here, it means that we have already
     created  a root element. So let's create a new element */
    XMLElement *newElement = [[XMLElement alloc] init];
    
    newElement.parent = self.currentElement;
    
    /* Also add the new element that we just created as
     the child element of the current element */
    [self.currentElement.children addObject:newElement];
    
    /* Now the current element becomes the new 
     element that we just created */
    self.currentElement = newElement;
    
    /* This is very important. Since the new element 
     is added to the children array of its parent
     element, we make sure we release it as
     the array has now retained this element */
    [newElement release];
  }
  
  self.currentElement.name = elementName;
  
  if ([attributeDict count] > 0){
    /* Also if we have attributes, let's make sure we add
     them to the attributes dictionary of the current element */
    [self.currentElement.attributes 
     addEntriesFromDictionary:attributeDict];
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
       foundCharacters:(NSString *)string{
  
  if (self.currentElement != nil){
    
    /* Here we have found some inner text for 
     the current element. This doesn't happen unless
     the current element does indeed have some
     text inside it. For instance:
     
     <person name="foo"/>
     <person name="bar">a friend of mine</person>
     
     The first person element does not have inner text
     but the second one does (inner text of the
     second element is [a friend of mine])
     */
    
    if (self.currentElement.text == nil){
      self.currentElement.text = string;
    } else {
      self.currentElement.text = 
        [self.currentElement.text
         stringByAppendingString:string];
    }
    
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
         didEndElement:(NSString *)elementName 
          namespaceURI:(NSString *)namespaceURI 
         qualifiedName:(NSString *)qName{
  
  if (self.currentElement != nil){
    /* For the description of this method, refer to the 
     comments written for the parser:didStartElement:namespaceURI:
     qualifiedName:attributes: method */
    self.currentElement = self.currentElement.parent;
  }
  
}

/* -------------------------- */

- (BOOL) parseLocalXMLWithPath:(NSString*)paramLocalXMLPath{
  
  BOOL result = NO;
  
  /* Let's make sure that the path is not empty */
  if ([paramLocalXMLPath length] == 0){
    NSLog(@"The given XML path is nil or empty.");
    return(NO);
  }
  
  /* Does this file exist? */
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  
  /* Make sure the file exists */
  if ([fileManager fileExistsAtPath:paramLocalXMLPath] == NO){
    NSLog(@"The given local path does not exist.");
    [fileManager release];
    return(NO);
  }
  
  [fileManager release];
  
  /* Form an NSData of the contents of the file */
  NSData *localXMLData = 
  [NSData dataWithContentsOfFile:paramLocalXMLPath];
  
  /* Could we get any data */
  if ([localXMLData length] == 0){
    NSLog(@"The local XML file could not be loaded.");
    return(NO);
  }
  
  if (self.xmlParser != nil){
    self.xmlParser = nil;
  }
  
  if (self.rootElement != nil){
    self.rootElement = nil;
  }
  
  /* Now start parsing */
  NSXMLParser *parser = 
  [[NSXMLParser alloc] initWithData:localXMLData];
  
  self.xmlParser = parser;
  
  [parser release];
  
  [self.xmlParser setDelegate:self];
  result = [self.xmlParser parse];
  
  return(result);
  
}

/* -------------------------- */

- (void) dealloc {
  NSLog(@"Deallocated document");
  
  [xmlParser release];
  [currentElement release];
  [rootElement release];
  [documentPath release];
  
  [super dealloc];
}

/* -------------------------- */

@end
