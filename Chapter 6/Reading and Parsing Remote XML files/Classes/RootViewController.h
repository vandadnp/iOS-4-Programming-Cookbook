//
//  RootViewController.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

// http://unicode.org/repos/cldr/trunk/common/main/fr.xml

#import <UIKit/UIKit.h>
#import "XMLDocument.h"

/* -------------------------- */

@interface RootViewController : UIViewController 
                                <XMLDocumentDelegate> {
@public
  XMLDocument     *xmlDocument;
  
}

/* -------------------------- */

@property (nonatomic, retain) XMLDocument     *xmlDocument;

/* -------------------------- */

@end
