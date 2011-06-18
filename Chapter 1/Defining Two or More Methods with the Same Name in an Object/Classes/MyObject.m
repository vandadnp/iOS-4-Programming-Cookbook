//
//  MyObject.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-06-05.
//  Copyright 2010  All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

/* --------------------------------------------- */

- (void) drawCircleWithCenter:(CGPoint)paramCenter 
                       radius:(CGFloat)paramRadius{
  
  /* Draw the circle here */
  
}

/* --------------------------------------------- */

- (void) drawCircleWithCenter:(CGPoint)paramCenter 
                       Radius:(CGFloat)paramRadius{
  
  /* Draw the circle here */
  
}

/* --------------------------------------------- */

- (void) drawRectangle{
  
  [self drawRectangleInRect:CGRectMake(0.0f, 0.0f, 4.0f, 4.0f)];
  
}

/* --------------------------------------------- */

- (void) drawRectangleInRect:(CGRect)paramInRect{
  
  [self drawRectangleInRect:paramInRect
                  withColor:[UIColor blueColor]];
  
}

/* --------------------------------------------- */

- (void) drawRectangleInRect:(CGRect)paramInRect 
             withColor:(UIColor*)paramColor{
  
  [self drawRectangleInRect:paramInRect
                  withColor:paramColor
                  andFilled:YES];
  
}

/* --------------------------------------------- */

- (void) drawRectangleInRect:(CGRect)paramInRect 
                   withColor:(UIColor*)paramColor 
                   andFilled:(BOOL)paramFilled{
  
  /* Draw the rectangle here */
  
}

/* --------------------------------------------- */

@end
