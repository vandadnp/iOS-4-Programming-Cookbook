//
//  MyObject.h
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>

/* --------------------------------------------- */

@interface MyObject : NSObject {
@public
  NSInteger myInteger;
}

/* --------------------------------------------- */

@property (nonatomic, assign) NSInteger myInteger;

/* --------------------------------------------- */

- (void) doSomething;

/* --------------------------------------------- */

@end
