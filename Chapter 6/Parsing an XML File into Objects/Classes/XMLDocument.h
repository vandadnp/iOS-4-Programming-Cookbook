//
//  XMLDocument.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>

/* -------------------------- */

@class XMLElement;

/* -------------------------- */

@interface XMLDocument : NSObject <NSXMLParserDelegate> {
@public
  NSString        *documentPath;
  XMLElement      *rootElement;
@private
  NSXMLParser     *xmlParser;
  XMLElement      *currentElement;
}

/* -------------------------- */

@property (nonatomic, retain) NSString        *documentPath;
@property (nonatomic, retain) XMLElement      *rootElement;

/* Private properties */
@property (nonatomic, retain) NSXMLParser     *xmlParser;
@property (nonatomic, retain) XMLElement      *currentElement;

/* -------------------------- */

- (BOOL) parseLocalXMLWithPath:(NSString *)paramLocalXMLPath;

/* -------------------------- */

@end
