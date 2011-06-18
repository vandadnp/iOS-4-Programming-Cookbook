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
@synthesize delegate;
@synthesize xmlParser;
@synthesize currentElement;
@synthesize connection;
@synthesize connectionData;
@synthesize parsingErrorHasHappened;

/* -------------------------- */

- (void)  connection:(NSURLConnection *)connection 
  didReceiveResponse:(NSURLResponse *)response{
  
  [self.connectionData setLength:0];
  
}

/* -------------------------- */

- (void)  connection:(NSURLConnection *)connection 
      didReceiveData:(NSData *)data{
  
  [self.connectionData appendData:data];
  
}

/* -------------------------- */

- (void)  connection:(NSURLConnection *)connection 
    didFailWithError:(NSError *)error{
  
  NSLog(@"A connection error has occurred.");
  
  [self.delegate xmlDocumentDelegateParsingFailed:self
                                        withError:error];
  
}

/* -------------------------- */

- (void)  connectionDidFinishLoading:(NSURLConnection *)connection{
  
  /* Now that we have finished downloading, let's start parsing
   the downloaded data */
  
  if (self.connectionData != nil){
    
    NSXMLParser *newParser = [[NSXMLParser alloc] 
                              initWithData:self.connectionData];
    
    self.xmlParser = newParser;
    [newParser release];
    
    [self.xmlParser setShouldProcessNamespaces:NO];
    [self.xmlParser setShouldReportNamespacePrefixes:NO];
    [self.xmlParser setShouldResolveExternalEntities:NO];
    [self.xmlParser setDelegate:self];
    if ([self.xmlParser parse] == YES){
      NSLog(@"Successfully parsed the remote file.");
    } else{
      NSLog(@"Failed to parse the remote file.");
    }
    
  }
  
}

/* -------------------------- */

- (void)          parser:(NSXMLParser *)parser 
      parseErrorOccurred:(NSError *)parseError{
  
  NSLog(@"Parsing error has occurred.");
  
  self.parsingErrorHasHappened = YES;
  
  /* Abort the parsing straight away */
  [parser abortParsing];
  
  [self.delegate xmlDocumentDelegateParsingFailed:self
                                        withError:parseError];
  
}

/* -------------------------- */

- (void)          parser:(NSXMLParser *)parser 
 validationErrorOccurred:(NSError *)validationError{
  
  NSLog(@"Validation error has occurred.");
  
  self.parsingErrorHasHappened = YES;

  [self.delegate xmlDocumentDelegateParsingFailed:self
                                        withError:validationError];
  
}

/* -------------------------- */

- (void)parserDidStartDocument:(NSXMLParser *)parser{
  
  self.parsingErrorHasHappened = NO;
 
}

/* -------------------------- */

- (void)parserDidEndDocument:(NSXMLParser *)parser{
  
  if (self.parsingErrorHasHappened == NO){
    [self.delegate xmlDocumentDelegateParsingFinished:self];
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
       didStartElement:(NSString *)elementName
          namespaceURI:(NSString *)namespaceURI
         qualifiedName:(NSString *)qName
            attributes:(NSDictionary *)attributeDict{
  
  if (self.rootElement == nil){
    XMLElement *newElement = [[XMLElement alloc] init];
    self.rootElement = newElement;
    self.currentElement = self.rootElement;
    [newElement release];
  } else {
    XMLElement *newElement = [[XMLElement alloc] init];
    newElement.parent = self.currentElement;
    [self.currentElement.children addObject:newElement];
    self.currentElement = newElement;
    [newElement release];
  }
  
  self.currentElement.name = elementName;
  
  if ([attributeDict count] > 0){
    [self.currentElement.attributes 
     addEntriesFromDictionary:attributeDict];
  }
  
}

/* -------------------------- */

- (void)        parser:(NSXMLParser *)parser 
       foundCharacters:(NSString *)string{
  
  if (self.currentElement != nil){
    
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
    self.currentElement = self.currentElement.parent;
  }

}

/* -------------------------- */

- (BOOL) parseRemoteXMLWithURL:(NSString *)paramRemoteXMLURL{
  
  BOOL result = NO;
  
  if ([paramRemoteXMLURL length] == 0){
    NSLog(@"The remote URL can not be nil or empty.");
    return(NO);
  }
  
  /* escape the URL with percentage signs */
  paramRemoteXMLURL = 
    [paramRemoteXMLURL
    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  /* Make sure our connection hasn't been created before */
  self.connection = nil;
  
  NSURL         *url = [NSURL URLWithString:paramRemoteXMLURL];
  NSURLRequest  *request = [NSURLRequest requestWithURL:url];
  
  /* Get rid of the previous download data (if any) */
  self.connectionData = nil;
  
  /* If we have already parsed another XML, then we have to
   get rid of its root element (all other child elements will then
   be deallocated automatically) */
  
  /* This is where we will store all our data */
  NSMutableData *newData = [[NSMutableData alloc] init];
  self.connectionData = newData;
  [newData release];
  
  /* Start the download process */
  NSURLConnection *newConnection = [[NSURLConnection alloc] 
                                    initWithRequest:request
                                    delegate:self
                                    startImmediately:YES];
  self.connection = newConnection;
  [newConnection release];
  
  return(result);
  
}

/* -------------------------- */

- (BOOL) parseLocalXMLWithPath:(NSString*)paramLocalXMLPath{
   
  BOOL result = NO;
  
  if (paramLocalXMLPath == nil ||
      [paramLocalXMLPath length] == 0){
    NSLog(@"The given XML path is nil or empty.");
    return(NO);
  }
  
  /* Does this file exist? */
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  if ([fileManager fileExistsAtPath:paramLocalXMLPath] == NO){
    NSLog(@"The given local path does not exist.");
    return(NO);
  }
    
  NSData *localXMLData = [NSData dataWithContentsOfFile:paramLocalXMLPath];
  
  if (localXMLData == nil){
    NSLog(@"The local XML file could not be loaded.");
    return(NO);
  }
  
  NSXMLParser *newParser = [[NSXMLParser alloc] initWithData:localXMLData];
  self.xmlParser = newParser;
  [newParser release];
  
  [self.xmlParser setDelegate:self];
  result = [self.xmlParser parse];
  
  return(result);
  
}

/* -------------------------- */

- (id) init {
  /* Call the designated initializer */
  return([self initWithDelegate:nil]);
}

/* -------------------------- */

- (id) initWithDelegate:(id<XMLDocumentDelegate>)paramDelegate{
  
  self = [super init];
  
  if (self != nil){
    delegate = paramDelegate;
  }
  
  return(self);
  
}

/* -------------------------- */

- (void) dealloc {
  
  if (connection != nil){
    [connection cancel];
  }
  [connection release];
  
  [connectionData release];
  [xmlParser release];
  [rootElement release];
  [currentElement release];
  [documentPath release];
    
  [super dealloc];
}

/* -------------------------- */

@end