//
//  CacheItem.h
//  Cache
//
//  Created by Vandad Nahavandipoor on 10-06-28.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>

@class CacheItem;

/* -------------------------- */

@protocol CacheItemDelegate <NSObject>

- (void) cacheItemDelegateSucceeded
  :(CacheItem *)paramSender
  withRemoteURL:(NSURL *)paramRemoteURL
  withAboutToBeReleasedData:(NSData *)paramAboutToBeReleasedData;


- (void) cacheItemDelegateFailed
  :(CacheItem *)paramSender
  remoteURL:(NSURL *)paramRemoteURL
  withError:(NSError *)paramError;

@end

/* -------------------------- */

@interface CacheItem : NSObject {
@public
  id<CacheItemDelegate> delegate;
  NSString              *remoteURL;
@private
  BOOL                  isDownloading;
  NSMutableData         *connectionData;
  NSURLConnection       *connection;
}

/* -------------------------- */

@property (nonatomic, retain) id<CacheItemDelegate> delegate;
@property (nonatomic, retain) NSString  *remoteURL;
@property (nonatomic, assign) BOOL      isDownloading;
@property (nonatomic, retain) NSMutableData *connectionData;
@property (nonatomic, retain) NSURLConnection *connection;

/* -------------------------- */

- (BOOL) startDownloadingURL:(NSString *)paramRemoteURL;

/* -------------------------- */

@end
