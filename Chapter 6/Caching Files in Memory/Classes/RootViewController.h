//
//  RootViewController.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>


/* -------------------------- */

@interface RootViewController : UIViewController {
@public
  NSURLConnection     *connection;
}

/* -------------------------- */

@property (nonatomic, retain) NSURLConnection     *connection;

/* -------------------------- */

- (IBAction) downloadData:(id)paramSender;

/* -------------------------- */


@end
