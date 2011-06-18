//
//  CustomTableViewCell.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright 2010  All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

/* ------------------------------------------- */

@synthesize labelDate;

/* ------------------------------------------- */

- (void) layoutSubviews{
  
  /* Position the subviews here */
  [super layoutSubviews];
    
  if (self.labelDate != nil){
    [self.contentView bringSubviewToFront:self.labelDate];
    
    /* The width of our label is always 100 pixels */
    CGRect frameforLabel;
    frameforLabel.size.width = 100.0f;
    /* The height of our label is also constant */
    frameforLabel.size.height = 25.0f;
    /* The x position of the label is the width of this cell minus the
     width of the label itself */
    frameforLabel.origin.x = self.contentView.frame.size.width - 
    frameforLabel.size.width;
    
    if (self.accessoryView != nil){
      /* If there is an accessory view set for this cell, then we
       shift our label further to the left */
      frameforLabel.origin.x -= self.accessoryView.frame.size.width;
    }
    
    /* The y position of the label is also constant */
    frameforLabel.origin.y = 5.0;
    self.labelDate.frame = frameforLabel;
  }
  
}

/* ------------------------------------------- */

- (BOOL) displayCurrentDateWithDate:(NSDate*)ParamDate{
  BOOL result = NO;
  
  if (self.labelDate == nil){
    return(NO);
  }
  
  if (ParamDate == nil){
    return(NO);
  }
  
  /* Format the given date and display it in the label */
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"dd/MM/YYYY"];
  self.labelDate.text = [formatter stringFromDate:ParamDate];
  [formatter release];
  
  return(result);
}

/* ------------------------------------------- */

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)reuseIdentifier {
  
  if ((self = [super initWithStyle:style 
                   reuseIdentifier:reuseIdentifier])) {
    
    /* Create our label here. We are not retaining the label so we
     will add it to the content view, remove it and then release it */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    labelDate = [label retain];
    [label release];
    
    labelDate.textAlignment = UITextAlignmentLeft;
    labelDate.textColor = [UIColor blackColor];
    labelDate.opaque = NO;
    labelDate.backgroundColor = [UIColor clearColor];
    labelDate.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.contentView addSubview:labelDate];

  }
  
  return self;
}

/* ------------------------------------------- */

- (void)dealloc {
  [labelDate release];
  [super dealloc];
}

/* ------------------------------------------- */

@end