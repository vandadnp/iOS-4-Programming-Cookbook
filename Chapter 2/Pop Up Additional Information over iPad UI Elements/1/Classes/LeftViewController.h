//
//  LeftViewController.h
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-09.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* --------------------- */

@class LeftViewController;

/* --------------------- */

@protocol LeftViewControllerDelegate <NSObject>
@required
- (void)        leftViewController:(LeftViewController*)paramSender
   itemIsSelectedWithItemIndexPath:(NSIndexPath*)paramItemIndexPath
                          itemText:(NSString*)paramItemText;
@end

/* --------------------- */

@interface LeftViewController : UITableViewController {
@public
  id<LeftViewControllerDelegate> delegate;
}

/* --------------------- */

@property (nonatomic, assign) id<LeftViewControllerDelegate> delegate;

/* --------------------- */

@end
