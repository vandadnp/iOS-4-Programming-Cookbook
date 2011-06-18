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
@property (nonatomic, assign) XMLElement      *rootElement;

/* Private properties */
@property (nonatomic, assign) NSXMLParser     *xmlParser;
@property (nonatomic, assign) XMLElement      *currentElement;

/* -------------------------- */

- (BOOL) parseLocalXMLWithPath:(NSString*)localXMLPath;

/* -------------------------- */

@end
