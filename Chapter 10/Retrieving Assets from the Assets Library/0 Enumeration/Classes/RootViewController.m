//
//  RootViewController.m
//  Camera
//
//  Created by Vandad Nahavandipoor on 10-07-21.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

/* ------------------------------- */

@implementation RootViewController

/* ------------------------------- */

@synthesize assetsLibrary;

/* ------------------------------- */

void (^groupAssetEnumerationBlock)(ALAsset *, NSUInteger, BOOL *) = 
^(ALAsset *result, NSUInteger index, BOOL *stop){
  
  /* Get the asset type */
  NSString *assetType = [result valueForProperty:ALAssetPropertyType];
  
  if ([assetType isEqualToString:ALAssetTypePhoto] == YES){
    NSLog(@"This is a photo asset");
  }
  
  else if ([assetType isEqualToString:ALAssetTypeVideo] == YES){
    NSLog(@"This is a video asset");
  }
  
  else if ([assetType isEqualToString:ALAssetTypeUnknown] == YES){
    NSLog(@"This is an unknown asset");
  }
  
  /* Get the URLs for the asset */
  NSDictionary  *assetURLs = 
  [result valueForProperty:ALAssetPropertyURLs];
  
  NSUInteger    assetCounter = 0;
  for (NSString *assetURLKey in assetURLs){
    assetCounter++;
    NSLog(@"Asset URL %lu = %@", 
          (unsigned long)assetCounter, 
          [assetURLs valueForKey:assetURLKey]);
  }
  
  /* Get the asset's representation object */
  ALAssetRepresentation *assetRepresentation = 
  [result defaultRepresentation];
  
  NSLog(@"Representation Size = %lld", [assetRepresentation size]);
  
};

/* ------------------------------- */

void (^assetGroupEnumerationBlock)(ALAssetsGroup *, BOOL *) = 
^(ALAssetsGroup *group, BOOL *stop){
  
  [group enumerateAssetsUsingBlock:groupAssetEnumerationBlock];
  
};

/* ------------------------------- */

void (^assetGroupEnumerationFailedBlock)(NSError *) = 
      ^(NSError *error){
  
  NSLog(@"Error = %@", error);
  
};

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.assetsLibrary 
   enumerateGroupsWithTypes:ALAssetsGroupAll
   usingBlock:assetGroupEnumerationBlock
   failureBlock:assetGroupEnumerationFailedBlock];
  
}

/* ------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (YES);
}

/* ------------------------------- */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

/* ------------------------------- */

- (id) initWithNibName:(NSString *)nibNameOrNil 
                bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil];
  
  if (self != nil){
    
    ALAssetsLibrary *newLibrary = [[ALAssetsLibrary alloc] init];
    assetsLibrary = [newLibrary retain];
    [newLibrary release];
    
  }
  
  return(self);
  
}

/* ------------------------------- */

- (void)dealloc {
  [assetsLibrary release];
  [super dealloc];
}

/* ------------------------------- */

@end
