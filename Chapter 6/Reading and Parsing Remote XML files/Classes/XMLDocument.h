//
//  XMLDocument.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLElement.h"

/* -------------------------- */

@class XMLDocument;

/* -------------------------- */

@protocol XMLDocumentDelegate <NSObject>

@required

  - (void) xmlDocumentDelegateParsingFinished
           :(XMLDocument *)paramSender;

  - (void) xmlDocumentDelegateParsingFailed
           :(XMLDocument *)paramSender 
  withError:(NSError *)paramError;

@end

/* -------------------------- */

@interface XMLDocument : NSObject <NSXMLParserDelegate> {
@public
  /* Keep the document path just in case we want to refer to it */
  NSString                    *documentPath;
  /* We will allocate and initialize the root element */
  XMLElement                  *rootElement;
  /* Our delegate which will get called if parsing
   finishes successfully or fails */
  id<XMLDocumentDelegate>     delegate;
@private
  /* Our private XML parser used for local and remote files */
  NSXMLParser                 *xmlParser;
  /* The pointer to the current element being parsed */
  XMLElement                  *currentElement;
  /* The URL connection we will use to download remote XML files */
  NSURLConnection             *connection;
  /* The mutable data that will hold the XML which
   is being downloaded */
  NSMutableData               *connectionData;
  /* We will set this value to YES and NO manually
   to prevent calling the wrong delegate messages */
  BOOL                        parsingErrorHasHappened;
}

/* -------------------------- */

@property (nonatomic, retain) NSString                *documentPath;
@property (nonatomic, retain) XMLElement              *rootElement;
@property (nonatomic, assign) id<XMLDocumentDelegate> delegate;

/* Private properties */
@property (nonatomic, retain) NSXMLParser       *xmlParser;
@property (nonatomic, retain) XMLElement        *currentElement;
@property (nonatomic, retain) NSURLConnection   *connection;
@property (nonatomic, retain) NSMutableData     *connectionData;
@property (nonatomic, assign) BOOL              parsingErrorHasHappened;

/* -------------------------- */

/* Designated Initializer */
- (id)    initWithDelegate:(id<XMLDocumentDelegate>)paramDelegate;

- (BOOL)  parseLocalXMLWithPath:(NSString *)paramLocalXMLPath;
- (BOOL)  parseRemoteXMLWithURL:(NSString *)paramRemoteXMLURL;

/* -------------------------- */

@end