//
//  CachedDownloadManager.h
//  Cache
//
//  Created by Vandad Nahavandipoor on 10-06-27.
//  Copyright 2010  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheItem.h"

/* -------------------------- */

@class CachedDownloadManager;

/* -------------------------- */

@protocol CachedDownloadManagerDelegate <NSObject>
@required

- (void) cachedDownloadManagerSucceeded
         :(CachedDownloadManager *)paramSender
         remoteURL:(NSURL *)paramRemoteURL
         localURL:(NSURL *)paramLocalURL
         aboutToBeReleasedData:(NSData *)paramAboutToBeReleasedData
         isCachedData:(BOOL)paramIsCachedData;

- (void) cachedDownloadManagerFailed
         :(CachedDownloadManager *)paramSender
         remoteURL:(NSURL *)paramRemoteURL
         localURL:(NSURL *)paramLocalURL
         withError:(NSError *)paramError;

@end

/* -------------------------- */

@interface CachedDownloadManager : NSObject 
                                   <CacheItemDelegate> {
@public
  id<CachedDownloadManagerDelegate>  delegate;
@private
  NSMutableDictionary                *cacheDictionary;
  NSString                           *cacheDictionaryPath;
}

/* -------------------------- */

@property (nonatomic, assign) 
id<CachedDownloadManagerDelegate> delegate;

@property (nonatomic, copy) 
NSMutableDictionary *cacheDictionary;

@property (nonatomic, retain) 
NSString *cacheDictionaryPath;

/* -------------------------- */

/* Private methods */

- (BOOL) saveCacheDictionary;

/* -------------------------- */

/* Public methods */

- (BOOL)         download:(NSString *)paramURLAsString
   urlMustExpireInSeconds:(NSTimeInterval)paramURLMustExpireInSeconds
updateExpiryDateIfInCache:(BOOL)paramUpdateExpiryDateIfInCache;

/* -------------------------- */

@end
