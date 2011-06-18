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

- (void)drawRect:(CGRect)rect {
  
  /* Get the current context */
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  /* The points of the rectangle that needs to be drawn */
  
  CGRect drawingRect = CGRectMake(0.0,      /* X */
                                  0.0f,     /* Y */
                                  100.0f,   /* Width */
                                  200.0f);  /* Height */
    
  /* Get the red color */
  const CGFloat *rectColorComponents = 
  CGColorGetComponents([UIColor redColor].CGColor);

  /* Draw with red fill color */
  CGContextSetFillColor(context, rectColorComponents);
  
  /* Now draw the rectangle */
  CGContextFillRect(context, drawingRect);
  
  /* The rectangular space in which the ellipse has to be drawn */
  CGRect ellipseRect = CGRectMake(160.0f,   /* X */
                                  200.0f,   /* Y */
                                  150.0f,   /* Width */
                                  200.0f);  /* Height */
  
  /* The blue color's components */
  const CGFloat *ellipseColorComponents = 
  CGColorGetComponents([UIColor blueColor].CGColor);
  
  /* Set the blue color as the current fill color */
  CGContextSetFillColor(context, ellipseColorComponents);
  
  /* And finally draw the ellipse */
  CGContextFillEllipseInRect(context, ellipseRect);
  
}

/* --------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* --------------------------------- */


@end
