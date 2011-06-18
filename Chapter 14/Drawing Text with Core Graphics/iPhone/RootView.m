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
  
  /* Save the state of the context */
  CGContextSaveGState(context);
  
  /* This is the font we wnat to use */
  UIFont *systemFont = [UIFont systemFontOfSize:16.0f];
  
  /* Get the name of the font */
  const char *fontNameAsCString = 
  [systemFont.fontName UTF8String];
    
  /* Using the font name, select the font into the context */
  CGContextSelectFont(context,
                      fontNameAsCString,
                      16.0f,
                      kCGEncodingMacRoman);
  
  /* Here is what we want to draw */
  const char *textToDraw = "Hello, World!";
  
  /* Now translate the context's coordinate and then 
   rotate the the context around the x axis (-1 for y)
   to access the cartesian coordinate system */
  CGContextTranslateCTM(context,
                        0.0f, 
                        self.bounds.size.height);
  
  CGContextScaleCTM(context,
                    1.0,
                    -1.0f);
  
  /* Now draw at X = 200 and Y = 100 */
  CGContextShowTextAtPoint(context,
                           200.0f,
                           100.0,
                           textToDraw,
                           strlen(textToDraw));
  
  /* Restore the state of the context */
  CGContextRestoreGState(context);
    
}

/* --------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* --------------------------------- */


@end
