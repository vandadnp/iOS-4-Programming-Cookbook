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

- (void) simpleUIImageDrawInRect:(CGRect)paramRect{
  
  UIImage *myImage = [UIImage imageNamed:@"Avatar.png"];
  [myImage drawInRect:paramRect];
  
}

/* --------------------------------- */

- (void) complexUIImageDrawInRect:(CGRect)paramRect{
  
  UIImage *myImage = [UIImage imageNamed:@"Avatar.png"];
  [myImage drawInRect:paramRect
            blendMode:kCGBlendModeDarken
                alpha:1.0f];

  
}

/* --------------------------------- */

- (void) drawBackgroundImageInRect:(CGRect)paramRect{
  
  UIImage *backgroundImage = 
  [UIImage imageNamed:@"Checkerboard.png"];
  
  [backgroundImage drawInRect:paramRect];
  
}

/* --------------------------------- */

- (void)drawRect:(CGRect)rect {
  
  [self drawBackgroundImageInRect:rect];
  
  /* The rectangle in which the first image will be drawn */
  CGRect destinationRect = CGRectMake(0.0f,     /* X */
                                      0.0f,     /* Y */
                                      128.0f,   /* W */
                                      128.0f);  /* H */
  
  [self simpleUIImageDrawInRect:destinationRect];
  
  /* For the second image, shift the destination rectangle down */
  destinationRect.origin.y += destinationRect.size.height;
  
  [self complexUIImageDrawInRect:destinationRect];
  
}

/* --------------------------------- */

- (void)dealloc {
  [super dealloc];
}

/* --------------------------------- */


@end
