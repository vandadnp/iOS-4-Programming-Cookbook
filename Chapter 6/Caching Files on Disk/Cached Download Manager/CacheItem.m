//
//  CacheItem.m
//  Cache
//
//  Created by Vandad Nahavandipoor on 10-06-28.
//  Copyright 2010  All rights reserved.
//

#import "CacheItem.h"

/* -------------------------- */

@implementation CacheItem

/* -------------------------- */

@synthesize delegate;
@synthesize remoteURL;
@synthesize isDownloading;
@synthesize connectionData;
@synthesize connection;

/* -------------------------- */

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response{

  [self.connectionData setLength:0];
}

/* -------------------------- */

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)data{
  
  [self.connectionData appendData:data];

}

/* -------------------------- */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  
  self.isDownloading = NO;
  
  if (self.delegate != nil){
    [self.delegate 
     cacheItemDelegateSucceeded:self
     withRemoteURL:[NSURL URLWithString:self.remoteURL]
     withAboutToBeReleasedData:self.connectionData];
  }
  
  self.connectionData = nil;
}

/* -------------------------- */

- (void)connection:(NSURLConnection *)connection 
  didFailWithError:(NSError *)error{
  
  
  if (self.delegate != nil){
    [self.delegate 
     cacheItemDelegateFailed:self
     remoteURL:[NSURL URLWithString:self.remoteURL]
     withError:error];
  }
  
  self.connectionData = nil;
  
  self.isDownloading = NO;
 
}

/* -------------------------- */

- (BOOL) startDownloadingURL:(NSString *)paramRemoteURL{
  
  /* we must have a delegate */
  BOOL result = NO;
  
  if (self.isDownloading == YES ||
      [paramRemoteURL length] == 0){
    return(NO);
  }
  
  self.isDownloading = YES;
  
  self.remoteURL = paramRemoteURL;
  
  self.connectionData = nil;
  
  NSMutableData *data = [[NSMutableData alloc] init];
  self.connectionData = data;
  [data release];
  
  NSURL *url = [NSURL URLWithString:paramRemoteURL];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  NSURLConnection *newConnection = [[NSURLConnection alloc] 
                                    initWithRequest:request
                                    delegate:self 
                                    startImmediately:YES];
  self.connection = newConnection;
  [newConnection release];
  
  if (self.connection != nil){
    result = YES;
  }
  
  return(result);
  
}

/* -------------------------- */

- (void) dealloc{
  if (connection != nil){
    [connection cancel];
  }
  [connection release];
  [connectionData release];
  [delegate release];
  [remoteURL release];
  [super dealloc];
}

/* -------------------------- */

@end
