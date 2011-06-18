//
//  XMLElement.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-17.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>

/* -------------------------- */

@interface XMLElement : NSObject {
@public
  NSString                *name;
  NSString                *text;
  XMLElement              *parent;
  NSMutableArray          *children;
  NSMutableDictionary     *attributes;
}

/* -------------------------- */

@property (nonatomic, retain)  NSString             *name;
@property (nonatomic, retain)  NSString             *text;
@property (nonatomic, assign)  XMLElement           *parent;
@property (nonatomic, assign)  NSMutableArray       *children;
@property (nonatomic, assign)  NSMutableDictionary  *attributes;

/* -------------------------- */

@end
