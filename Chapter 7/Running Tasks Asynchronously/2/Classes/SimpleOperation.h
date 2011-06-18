//
//  CountingOperation.h
//  Operations
//
//  Created by Vandad Nahavandipoor on 10-08-29.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>

/* -------------------------- */

@interface SimpleOperation : NSOperation {
@protected
  NSObject      *givenObject;
  BOOL          finished;
  BOOL          executing;
}

/* -------------------------- */

/* Designated Initializer */
- (id) initWithObject:(NSObject *)paramObject;

/* -------------------------- */

@end