//
//  CustomTableViewCell.h
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-04-24.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ------------------------------------------- */

@interface CustomTableViewCell : UITableViewCell {
@public
  UILabel *labelDate;
}

/* ------------------------------------------- */

@property (nonatomic, retain) UILabel *labelDate;

/* ------------------------------------------- */

- (BOOL) displayCurrentDateWithDate:(NSDate*)ParamDate;

/* ------------------------------------------- */

@end
