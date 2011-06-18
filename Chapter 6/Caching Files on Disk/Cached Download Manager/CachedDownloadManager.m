//
//  CachedDownloadManager.m
//  Cache
//
//  Created by Vandad Nahavandipoor on 10-06-27.
//  Copyright 2010  All rights reserved.
//

#import "CachedDownloadManager.h"

/* -------------------------- */

@implementation CachedDownloadManager

/* -------------------------- */

@synthesize delegate;
@synthesize cacheDictionary;
@synthesize cacheDictionaryPath;

/* -------------------------- */

const NSString *CachedKeyLocalURL = 
@"LocalURL";

const NSString *CachedKeyDownloadStartDate = 
@"DownloadStartDate";

const NSString *CachedKeyDownloadEndDate = 
@"DownloadEndDate";

const NSString *CachedKeyExpiresInSeconds =
@"ExpiresInSeconds";

const NSString *CachedKeyExpiryDate = 
@"ExpiryDate";

/* -------------------------- */

- (void) cacheItemDelegateSucceeded:(CacheItem *)paramSender
         withRemoteURL:(NSURL *)paramRemoteURL
        withAboutToBeReleasedData:(NSData *)paramAboutToBeReleasedData{
  
  /* Now let's see which item we just downloaded */
  
  NSMutableDictionary *dictionary = 
  [self.cacheDictionary objectForKey:[paramRemoteURL absoluteString]];
  
  NSDate *now = [NSDate date];
  
  NSNumber *expiresInSeconds = [dictionary 
                                objectForKey:CachedKeyExpiresInSeconds];
  
  NSTimeInterval expirySeconds = [expiresInSeconds floatValue];
  
  [dictionary setObject:[NSDate date]
                 forKey:CachedKeyDownloadEndDate];
  
  [dictionary setObject:[now dateByAddingTimeInterval:expirySeconds]
                 forKey:CachedKeyExpiryDate];
  
  [self saveCacheDictionary];
  
  NSString *localURL = [dictionary objectForKey:CachedKeyLocalURL];
  
  /* Now let's save the contents of the file to a disk */
  if ([paramAboutToBeReleasedData writeToFile:localURL
                                   atomically:YES] == YES){
    NSLog(@"Successfully cached the file on disk.");
  } else{
    NSLog(@"Failed to cache the file on disk.");
  }
  
  [self.delegate 
   cachedDownloadManagerSucceeded:self
   remoteURL:paramRemoteURL
   localURL:[NSURL URLWithString:localURL]
   aboutToBeReleasedData:paramAboutToBeReleasedData
   isCachedData:NO];
  
  
}

/* -------------------------- */

- (void) cacheItemDelegateFailed:(CacheItem *)paramSender
                       remoteURL:(NSURL *)paramRemoteURL
                       withError:(NSError *)paramError{
  
  /* We have to remove the current item from the list and send
   a delegate message */
  
  if (self.delegate != nil){
    
    NSMutableDictionary *dictionary = 
    [self.cacheDictionary 
     objectForKey:[paramRemoteURL absoluteString]];
    
    NSString *localURL = [dictionary 
                          objectForKey:CachedKeyLocalURL];
    
    [self.delegate
     cachedDownloadManagerFailed:self
     remoteURL:paramRemoteURL
     localURL:[NSURL URLWithString:localURL]
     withError:paramError];
  }
  
  [self.cacheDictionary 
   removeObjectForKey:[paramRemoteURL absoluteString]];
  
}

/* -------------------------- */

- (NSString *) documentsDirectoryWithTrailingSlash
               :(BOOL)paramWithTrailingSlash{
  
  NSString *result = nil;
  
  NSArray *documents = 
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                      NSUserDomainMask,
                                      YES);
  
  if ([documents count] > 0){
    result = [documents objectAtIndex:0];
    
    if (paramWithTrailingSlash == YES){
      result = [result stringByAppendingString:@"/"];
    }
    
  }
  
  return(result);
}

/* -------------------------- */

- (void) removeCorruptedCachedItems{
  
  /* Now let's clean the dictionary by removing any items
   that have not been downloaded fully */
  NSMutableArray *keysToRemove = [NSMutableArray array];
  
  for (NSMutableDictionary *itemKey in self.cacheDictionary){
    
    NSMutableDictionary *itemDictionary = 
    [self.cacheDictionary objectForKey:itemKey];
    
    if ([itemDictionary 
         objectForKey:CachedKeyDownloadEndDate] == nil){
      NSLog(@"This file didn't get downloaded fully. Removing.");
      [keysToRemove addObject:itemKey];
    }
  }
  
  [self.cacheDictionary removeObjectsForKeys:keysToRemove];
  
}

/* -------------------------- */

- (id) init{
  
  self = [super init];
  
  if (self != nil){
    
    NSString *documentsDirectory = 
    [self documentsDirectoryWithTrailingSlash:YES];
    
    cacheDictionaryPath = 
    [[documentsDirectory 
      stringByAppendingString:@"CachedDownloads.dic"] retain];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if ([fileManager 
         fileExistsAtPath:self.cacheDictionaryPath] == YES){
      
      NSMutableDictionary *dictionary = 
      [[NSMutableDictionary alloc] 
       initWithContentsOfFile:self.cacheDictionaryPath];
      
      cacheDictionary = [dictionary mutableCopy];
      
      [dictionary release];
      
      
      [self removeCorruptedCachedItems];
      
    } else {
      
      NSMutableDictionary *dictionary = 
      [[NSMutableDictionary alloc] init];
      
      cacheDictionary = [dictionary mutableCopy];
      
      [dictionary release];
      
    }
    
    [fileManager release];
    
    if ([cacheDictionaryPath length] > 0 &&
        cacheDictionary != nil){
      NSLog(@"Successfully initialized the cached dictionary.");
    } else {
      NSLog(@"Failed to initialize the cached dictionary.");
    }
    
  }
  
  return(self);
  
}

/* -------------------------- */

- (BOOL) saveCacheDictionary{
  
  BOOL result = NO;
  
  if ([self.cacheDictionaryPath length] == 0 ||
      self.cacheDictionary == nil){
    return(NO);
  }
  
  result = [self.cacheDictionary 
            writeToFile:self.cacheDictionaryPath
            atomically:YES];
  
  return(result);
  
}

/* -------------------------- */

- (BOOL)         download:(NSString *)paramURLAsString
   urlMustExpireInSeconds:(NSTimeInterval)paramURLMustExpireInSeconds
updateExpiryDateIfInCache:(BOOL)paramUpdateExpiryDateIfInCache{
  
  BOOL result = NO;
  
  if (self.cacheDictionary == nil ||
      [paramURLAsString length] == 0){
    return(NO);
  }
  
  paramURLAsString = [paramURLAsString lowercaseString];
  
  NSMutableDictionary *itemDictionary = 
  [self.cacheDictionary objectForKey:paramURLAsString];
  
  /* Use of Boolean values to make it easier for us
   to understand the logic behind caching */
  BOOL    fileHasBeenCached = NO;
  BOOL    cachedFileHasExpired = NO;
  BOOL    cachedFileExists = NO;
  BOOL    cachedFileDataCanBeLoaded = NO;
  NSData  *cachedFileData = nil;
  BOOL    cachedFileIsFullyDownloaded = NO;
  BOOL    cachedFileIsBeingDownloaded = NO;
  
  NSDate    *expiryDate = nil;
  NSDate    *downloadEndDate = nil;
  NSDate    *downloadStartDate = nil;
  NSString  *localURL = nil;
  NSNumber  *expiresInSeconds = nil;
  NSDate    *now = [NSDate date];
  
  if (itemDictionary != nil){
    fileHasBeenCached = YES;
  }
  
  if (fileHasBeenCached == YES){
    
    expiryDate = [itemDictionary 
                  objectForKey:CachedKeyExpiryDate];
    
    downloadEndDate = [itemDictionary
                       objectForKey:CachedKeyDownloadEndDate];
    
    downloadStartDate = [itemDictionary
                         objectForKey:CachedKeyDownloadStartDate];
    
    localURL = [itemDictionary
                objectForKey:CachedKeyLocalURL];
    
    expiresInSeconds = [itemDictionary
                        objectForKey:CachedKeyExpiresInSeconds];
    
    if (downloadEndDate != nil && 
        downloadStartDate != nil){
      cachedFileIsFullyDownloaded = YES;
    }
    
    /* If we know the number of seconds, after the download
     process is finished, when the content expires and we 
     still do not have the time when the download has finished, 
     that means we have added this content to the list but have not
     yet downloaded it fully */
    if (expiresInSeconds != nil &&
        downloadEndDate == nil){
      cachedFileIsBeingDownloaded = YES;
    }
    
    /* If the expiry date is less than today's date then this
     means that the content has expired */
    if (expiryDate != nil &&
        [now timeIntervalSinceDate:expiryDate] > 0.0){
      cachedFileHasExpired = YES;
    }
    
    if (cachedFileHasExpired == NO){
      /* The Cached File Has Not Expired. Try to load it and also
       update the expiry date */
      NSFileManager *fileManager = [[NSFileManager alloc] init];
      
      if ([fileManager fileExistsAtPath:localURL] == YES){
        cachedFileExists = YES;
        cachedFileData = [NSData dataWithContentsOfFile:localURL];
        if (cachedFileData != nil){
          cachedFileDataCanBeLoaded = YES;
        } /* if (cachedFileData != nil){ */
      } /* if ([fileManager fileExistsAtPath:localURL] == YES){ */
      
      [fileManager release];
      
      /* Update the expiry date. If the file has been 
       downloaded and has not expired yet but a new expiry
       number of seconds is proposed and we are asked to
       update the expiry date, 
       then we must update the expiry date */
      
      if (paramUpdateExpiryDateIfInCache == YES){
        
        NSDate *newExpiryDate = 
        [NSDate dateWithTimeIntervalSinceNow:
         paramURLMustExpireInSeconds];
        
        NSLog(@"Updating the expiry date from %@ to %@.", 
              expiryDate, 
              newExpiryDate);
        
        [itemDictionary setObject:newExpiryDate
                           forKey:CachedKeyExpiryDate];
        
        NSNumber *expires = 
        [NSNumber numberWithFloat:paramURLMustExpireInSeconds];
        
        [itemDictionary setObject:expires
                           forKey:CachedKeyExpiresInSeconds];
      }
      
    } /* if (cachedFileHasExpired == NO){ */
    
  }
  
  if (cachedFileIsBeingDownloaded == YES){
    NSLog(@"This file is already being downloaded...");
    return(YES);
  }
  
  if (fileHasBeenCached == YES){
    
    if (cachedFileHasExpired == NO &&
        cachedFileExists == YES &&
        cachedFileDataCanBeLoaded == YES &&
        [cachedFileData length] > 0 &&
        cachedFileIsFullyDownloaded == YES){
      
      /* The item has been cached and its data has been read.
       Also, it has not yet been expired so let's 
       just return this data */
      
      NSLog(@"This file has been cached and not expired yet.");
      
      [self.delegate 
       cachedDownloadManagerSucceeded:self
       remoteURL:[NSURL URLWithString:paramURLAsString]
       localURL:[NSURL URLWithString:localURL]
       aboutToBeReleasedData:cachedFileData
       isCachedData:YES];
      
      return(YES);
      
    } else {
      /* The file was not cached or not cached properly */
      NSLog(@"This file is not properly cached.");
      [self.cacheDictionary removeObjectForKey:paramURLAsString];
      [self saveCacheDictionary];
    } /* if (cachedFileHasExpired == NO && */
    
  } /* if (fileHasBeenCached == YES){ */
  
  /* Now let's try to download the file */
  
  
  NSNumber *expires = 
  [NSNumber numberWithFloat:paramURLMustExpireInSeconds];
  
  NSMutableDictionary *newDictionary = 
  [[[NSMutableDictionary alloc] init] autorelease];
  
  [newDictionary setObject:expires 
                    forKey:CachedKeyExpiresInSeconds];
  
  
  localURL = [paramURLAsString
              stringByAddingPercentEscapesUsingEncoding:
              NSUTF8StringEncoding];
  
  localURL = [localURL stringByReplacingOccurrencesOfString:@"://"
                                                 withString:@""];
  
  localURL = [localURL stringByReplacingOccurrencesOfString:@"/"
                                                 withString:@"$"];
  
  localURL = [localURL stringByAppendingPathExtension:@"cache"];
  
  NSString *documentsDirectory = 
  [self documentsDirectoryWithTrailingSlash:NO];
  
  localURL = [documentsDirectory 
              stringByAppendingPathComponent:localURL];
  
  [newDictionary setObject:localURL
                    forKey:CachedKeyLocalURL];
  
  [newDictionary setObject:now
                    forKey:CachedKeyDownloadStartDate];
  
  [self.cacheDictionary setObject:newDictionary
                           forKey:paramURLAsString];
  
  [self saveCacheDictionary];
  
  CacheItem *item = [[[CacheItem alloc] init] autorelease];
  [item setDelegate:self];
  [item startDownloadingURL:paramURLAsString];
  
  return(result);
  
}

/* -------------------------- */

- (void) dealloc {

  if (cacheDictionary != nil){
    [self saveCacheDictionary];
  }
  [cacheDictionary release];
  [cacheDictionaryPath release];
  
  [super dealloc];
  
}

/* -------------------------- */

@end
