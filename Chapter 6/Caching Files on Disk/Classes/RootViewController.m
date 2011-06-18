//
//  RootViewController.m
//  XML
//
//  Created by Vandad Nahavandipoor on 10-06-14.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

/* -------------------------- */

@implementation RootViewController

/* -------------------------- */

@synthesize downloadManager;

/* -------------------------- */

- (void) cachedDownloadManagerSucceeded:(CachedDownloadManager *)paramSender
                              remoteURL:(NSURL *)paramRemoteURL
                               localURL:(NSURL *)paramLocalURL
                  aboutToBeReleasedData:(NSData *)paramAboutToBeReleasedData
                           isCachedData:(BOOL)paramIsCachedData{  

}

/* -------------------------- */

- (void) cachedDownloadManagerFailed:(CachedDownloadManager *)paramSender
                           remoteURL:(NSURL *)paramRemoteURL
                            localURL:(NSURL *)paramLocalURL
                           withError:(NSError *)paramError{
  
}

/* -------------------------- */

- (IBAction) performDownloadFile:(id)Sender{
  
  static NSString *url = @"http://www.oreilly.com";
  
  [self.downloadManager download:url
      urlMustExpireInSeconds:20.0f
    updateExpiryDateIfInCache:YES];
  
}

/* -------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];  
  
  CachedDownloadManager *newManager = [[CachedDownloadManager alloc] init];
  self.downloadManager = newManager;
  [newManager release];
  
  [self.downloadManager setDelegate:self];
  
  [self.downloadManager download:@"http://support.apple.com/downloads/DL851/en_US/iPhoneConfigurationUtility.dmg"
      urlMustExpireInSeconds:20.0f
    updateExpiryDateIfInCache:NO];
  
}

/* -------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.downloadManager = nil;
  
}

/* -------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return (YES);
}

/* -------------------------- */

- (void)dealloc {
  
  [downloadManager release];
  
  [super dealloc];
  
}

/* -------------------------- */

@end
