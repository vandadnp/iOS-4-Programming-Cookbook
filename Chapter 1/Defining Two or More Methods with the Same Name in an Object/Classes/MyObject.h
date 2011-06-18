//
//  MyObject.h
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyObject : NSObject {

}

- (void) drawRectangle;

- (void) drawRectangleInRect:(CGRect)paramInRect;

- (void) drawRectangleInRect:(CGRect)paramInRect 
                   withColor:(UIColor*)paramColor;

- (void) drawRectangleInRect:(CGRect)paramInRect 
                   withColor:(UIColor*)paramColor 
                   andFilled:(BOOL)paramFilled;  

@end
