//
//  RootView.m
//  Graphics
//
//  Created by Vandad Nahavandipoor on 10-08-01.
//  Copyright 2010  All rights reserved.
//

#import "RootView.h"


@implementation RootView

/* --------------------------------- */

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    // Initialization code
  }
  return self;
}

/* --------------------------------- */

//- (void) addFilledRectangleToPathOnContext:(CGContextRef)paramContext{
//  
//  /* The points of the rectangle that needs to be drawn */
//  
//  CGRect drawingRect = CGRectMake(0.0,      /* X */
//                                  0.0f,     /* Y */
//                                  100.0f,   /* Width */
//                                  200.0f);  /* Height */
//  
//  UIColor *halfTransparentGreenColor = 
//  [UIColor colorWithRed:0.0f
//                  green:1.0f
//                   blue:0.0f
//                  alpha:0.5f];
//  
//  const CGFloat *rectangleFillColor = 
//  CGColorGetComponents(halfTransparentGreenColor.CGColor);
//  
//  CGContextSetFillColor(paramContext, rectangleFillColor);
//  
//  CGContextAddRect(paramContext, drawingRect);
//  
//  CGContextFillPath(paramContext);
//  
//}

/* --------------------------------- */

//- (void) addStrokedEllipseToPathOnContext:(CGContextRef)paramContext{
//  
//  CGRect ellipseRect = CGContextGetClipBoundingBox(paramContext);
//  
//  CGContextAddEllipseInRect(paramContext, ellipseRect);
//  
//  CGContextSetStrokeColorWithColor(paramContext, 
//                                   [UIColor brownColor].CGColor);
//  
//  CGContextStrokePath(paramContext);
//  
//}

/* --------------------------------- */

//- (void)drawRect:(CGRect)rect {
//  
//  /* Get the current context */
//  CGContextRef context = UIGraphicsGetCurrentContext();
//    
//  CGContextBeginPath(context);
//  
//  /* Add a filled rectangle to the current path */
//  [self addFilledRectangleToPathOnContext:context];
//  
//  /* Add a stroked ellipse to the current path */
//  [self addStrokedEllipseToPathOnContext:context];
//  
//  CGContextClosePath(context);
//  
//}

/* --------------------------------- */

//- (void)drawRect:(CGRect)rect {
//  
//  CGPoint trianglePoints[3] = {
//    CGPointMake(100.0f, 100.0f),
//    CGPointMake(200.0f, 200.0f),
//    CGPointMake(0.0f, 200.0),
//  };
//  
//  /* Get the current context */
//  CGContextRef context = UIGraphicsGetCurrentContext();
//  
//  CGContextBeginPath(context);
//  
//  /* Move the initial point on the path to (100, 100) */
//  CGContextMoveToPoint(context, 
//                       trianglePoints[0].x, 
//                       trianglePoints[0].y);
//  
//  /* Move from (100, 100) to (200, 200) and draw a line */
//  CGContextAddLineToPoint(context, 
//                          trianglePoints[1].x, 
//                          trianglePoints[1].y);
//  
//  /* From point (200, 200), draw a line to (0, 200) */
//  CGContextAddLineToPoint(context, 
//                          trianglePoints[2].x, 
//                          trianglePoints[2].y);
//  
//  /* Close the path */
//  CGContextClosePath(context);
//  
//  /* Set the fill color to red */
//  CGContextSetFillColorWithColor(context,
//                                 [UIColor redColor].CGColor);
//  
//  /* And fill the path with red */
//  CGContextFillPath(context);
//  
//}

- (void)drawRect:(CGRect)rect {
  
  CGPoint trianglePoints[3] = {
    CGPointMake(100.0f, 100.0f),
    CGPointMake(200.0f, 200.0f),
    CGPointMake(0.0f, 200.0),
  };
  
  /* Get the current context */
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGMutablePathRef path = CGPathCreateMutable();
  
  /* Move the initial point on the path to (100, 100) */
  CGPathMoveToPoint(path, 
                    nil, 
                    trianglePoints[0].x, 
                    trianglePoints[0].y);
  
  /* Move from (100, 100) to (200, 200) and draw a line */
  CGPathAddLineToPoint(path, 
                       nil, 
                       trianglePoints[1].x, 
                       trianglePoints[1].y);
  
  /* From point (200, 200), draw a line to (0, 200) */
  CGPathAddLineToPoint(path, 
                       nil, 
                       trianglePoints[2].x, 
                       trianglePoints[2].y);
  
  /* Set the fill color to red */
  CGContextSetFillColorWithColor(context,
                                 [UIColor redColor].CGColor);
  
  
  /* Create a new path on the context */
  CGContextBeginPath(context);
  /* Add our path to the current path on the context */
  CGContextAddPath(context, path);
  /* Close the path */
  CGContextClosePath(context);
  /* And fill the path with red */
  CGContextFillPath(context);
  
  /* And make sure that we release the mutable path
   object that we created earlier */
  CGPathRelease(path);
  
}

/* --------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* --------------------------------- */


@end
