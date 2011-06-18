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
@synthesize imageView;

/* ------------------------------- */

void (^groupAssetEnumerationBlock)(ALAsset *, NSUInteger, BOOL *) = 
^(ALAsset *result, NSUInteger index, BOOL *stop){

  static BOOL firstImageIsFound = NO;
  
  /* We don't want to get all the images. As soon as we get
   the first image, we want to end the enumeration */
  if (firstImageIsFound == YES){
    *stop = YES;
    return;
  }
  
  /* Get the asset type */
  NSString *assetType = [result valueForProperty:ALAssetPropertyType];
  
  if ([assetType isEqualToString:ALAssetTypePhoto] == YES){
    NSLog(@"This is a photo asset");
    firstImageIsFound = YES;
    
    /* Get the asset's representation object */
    ALAssetRepresentation *assetRepresentation = 
    [result defaultRepresentation];
    
    /* We need the scale and orientationt to be able to
     construct a properly oriented and scaled UIImage out of the
     representation object */
    CGFloat     imageScale = [assetRepresentation scale];
    
    UIImageOrientation  imageOrientation = 
    [assetRepresentation orientation];
    
    CGImageRef  imageReference = 
    [assetRepresentation fullResolutionImage];
    
    /* Construct the image now */
    UIImage     *image = 
    [[UIImage alloc] initWithCGImage:imageReference
                               scale:imageScale
                         orientation:imageOrientation];
    
    if (image != nil){
      
      /* Send a notification saying that we have constructed
       the image */
      [[NSNotificationCenter defaultCenter] 
       postNotificationName:NOTIFICATION_ASSET_IMAGE_RETRIEVED
       object:image];
      
    } else {
      NSLog(@"Failed to create the image.");
    }
    
    [image release];
    
  }
  
};

/* ------------------------------- */

void (^assetGroupEnumerationBlock)(ALAssetsGroup *, BOOL *) = 
^(ALAssetsGroup *group, BOOL *stop){
  
  [group enumerateAssetsUsingBlock:groupAssetEnumerationBlock];
  
};

/* ------------------------------- */

void (^assetGroupEnumerationFailedBlock)(NSError *) = 
^(NSError *error){
  
  NSLog(@"Group enumeration Error = %@", error);
  
};

/* ------------------------------- */

- (void) createImageViewOutOfImage:(NSNotification *)paramNotification{
  
  UIImage *image = (UIImage *)[paramNotification object];
  
  if (image == nil){
    NSLog(@"The given image is nil.");
    return;
  }
  
  /* Create the image view with the view's bounds */
  UIImageView *newImageView = [[UIImageView alloc] 
                               initWithFrame:self.view.bounds];
  self.imageView = [newImageView retain];
  [newImageView release];
  
  /* Make sure the image gets scaled properly in the image view */
  [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
  [self.imageView setImage:image];
  
  /* And add the image view to the view */
  [self.view addSubview:self.imageView];
  
}

/* ------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] 
   addObserver:self
   selector:@selector(createImageViewOutOfImage:)
   name:NOTIFICATION_ASSET_IMAGE_RETRIEVED
   object:nil];
  
  [self.assetsLibrary 
   enumerateGroupsWithTypes:ALAssetsGroupAll
   usingBlock:assetGroupEnumerationBlock
   failureBlock:assetGroupEnumerationFailedBlock];
  
}

/* ------------------------------- */

- (void)viewDidUnload {
  [super viewDidUnload];  
  self.imageView = nil;
  
  [[NSNotificationCenter defaultCenter] 
   removeObserver:self
   name:NOTIFICATION_ASSET_IMAGE_RETRIEVED
   object:nil];
  
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
  [imageView release];
  [super dealloc];
}

/* ------------------------------- */

@end
