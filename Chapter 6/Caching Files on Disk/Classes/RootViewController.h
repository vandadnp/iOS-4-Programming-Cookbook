//
//  RootViewController.h
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedDownloadManager.h"
/* -------------------------- */

@interface RootViewController : UIViewController <CachedDownloadManagerDelegate> {
@public
  CachedDownloadManager   *downloadManager;
}

/* -------------------------- */

@property (nonatomic, retain) CachedDownloadManager   *downloadManager;

/* -------------------------- */

- (IBAction) performDownloadFile:(id)Sender;

/* -------------------------- */
@end
