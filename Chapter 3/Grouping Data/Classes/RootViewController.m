//
//  RootViewController.m
//  Tables
//
//  Created by Vandad Nahavandipoor on 10-07-12.
//  Copyright 2010  All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

/* ------------------------------------------- */

@synthesize myTableView;
@synthesize arrayOfSections;

/* ------------------------------------------- */

//- (NSInteger)tableView:(UITableView *)table 
// numberOfRowsInSection:(NSInteger)section{
//  
//  NSInteger result = 0;
//  
//  if ([table isEqual:self.myTableView] == YES){
//    
//    if (self.arrayOfSections != nil &&
//        [self.arrayOfSections count] > section){
//      
//      NSMutableArray *thisSection = 
//      [self.arrayOfSections objectAtIndex:section];
//      
//      result = [thisSection count];
//      
//    }
//    
//  } /* if ([table isEqual:self.myTableView] == YES){ */
//  
//  return(result);
//  
//}

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section{
  
  NSInteger result = 0;
  
  if ([table isEqual:self.myTableView] == YES){
    
    if (self.arrayOfSections != nil &&
        [self.arrayOfSections count] > section){
      
      /* Get the section */
      NSMutableDictionary *thisSection = 
      [self.arrayOfSections objectAtIndex:section];
      
      NSMutableArray *thisSectionValues = 
      [thisSection valueForKey:@"Values"];
      
      result = [thisSectionValues count];
      
    }
    
  } /* if ([table isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

//- (UITableViewCell *)tableView:(UITableView *)tableView 
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//  UITableViewCell* result = nil;
//  
//  /* Reusable identifier of our cells */
//  static NSString *MyCellIdentifier = @"SimpleCells";
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    
//    /* Can we reuse the cells */
//    result = 
//    [tableView 
//     dequeueReusableCellWithIdentifier:MyCellIdentifier];
//    
//    if (result == nil){
//      /* Could not get a reusable cell. Create one */
//      result = [[[UITableViewCell alloc] 
//                 initWithStyle:UITableViewCellStyleDefault 
//                 reuseIdentifier:MyCellIdentifier] autorelease];
//    }
//    
//    /* Does this array have values? */
//    if (self.arrayOfSections != nil &&
//        [self.arrayOfSections count] > indexPath.section){
//      
//      /* Get the section */
//      NSMutableArray *thisSection = 
//      [self.arrayOfSections objectAtIndex:indexPath.section];
//      
//      /* Now get the row */
//      if ([thisSection count] > indexPath.row){
//        result.textLabel.text = 
//        [thisSection objectAtIndex:indexPath.row];
//      }
//    }
//    
//  } /* if ([tableView isEqual:self.myTableView] == YES){ */
//  
//  return(result);
//  
//}

/* ------------------------------------------- */

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForHeaderInSection:(NSInteger)section{
  
  CGFloat result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = 40.0f;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForFooterInSection:(NSInteger)section{
  
  CGFloat result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    result = 40.0f;
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (UIView *)    tableView:(UITableView *)tableView 
   viewForHeaderInSection:(NSInteger)section{
  
  UIView *result = nil;
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    /* Do we have as many sections as specified? */
    if (self.arrayOfSections != nil &&
        [self.arrayOfSections count] > section){
      
      /* Get the dictionary for our section */
      NSMutableDictionary *thisSection = 
      [self.arrayOfSections objectAtIndex:section];
      
      /* We can't insert nil into an array, so if we can get the dictionary
       out of our array of sections, we don't have to do any check to see if
       it is nil. */
      
      /* Get the value to display for our header */
      NSString *headerValue = [thisSection objectForKey:@"Header"];
      
      /* Construct a label for our header. Size is ignored here */
      UILabel *myLabel = [[[UILabel alloc]
                           initWithFrame:CGRectZero] autorelease];
      
      myLabel.backgroundColor = [UIColor clearColor];
      myLabel.textAlignment = UITextAlignmentCenter;
      myLabel.text = headerValue;
      result = myLabel;
      
    } /* if (self.arrayofSections != nil && ... */
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

//- (NSString *)  tableView:(UITableView *)tableView 
//  titleForFooterInSection:(NSInteger)section{
//  
//  NSString *result = nil;
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    
//    if (self.arrayOfSections != nil &&
//        [self.arrayOfSections count] > section){
//      
//      NSMutableDictionary *thisSection = 
//      [self.arrayOfSections objectAtIndex:section];
//      
//      if (thisSection != nil){
//        result = [thisSection objectForKey:@"Footer"];
//      }
//      
//    } /* if (self.arrayofSections != nil && ... */
//    
//  } /* if ([tableView isEqual:self.myTableView] == YES){ */
//  
//  return(result);
//  
//}


//- (NSString *)  tableView:(UITableView *)tableView 
//  titleForHeaderInSection:(NSInteger)section{
//  
//  NSString *result = nil;
//  
//  if ([tableView isEqual:self.myTableView] == YES){
//    
//    if (self.arrayOfSections != nil &&
//        [self.arrayOfSections count] > section){
//      
//      NSMutableDictionary *thisSection = 
//      [self.arrayOfSections objectAtIndex:section];
//      
//      if (thisSection != nil){
//        result = [thisSection objectForKey:@"Header"];
//      }
//      
//    }
//    
//  } /* if ([tableView isEqual:self.myTableView] == YES){ */
//  
//  return(result);
//  
//}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell* result = nil;
  
  /* Reusable identifier of our cells */
  static NSString *MyCellIdentifier = @"SimpleCells";
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    /* Can we reuse the cells */
    result = 
    [tableView 
     dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (result == nil){
      /* Could not get a reusable cell. Create one */
      result = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:MyCellIdentifier] autorelease];
    }
    
    /* Does this array have values? */
    if (self.arrayOfSections != nil &&
        [self.arrayOfSections count] > indexPath.section){
      
      /* Get the section */
      NSMutableDictionary *thisSection = 
      [self.arrayOfSections objectAtIndex:indexPath.section];
      
      /* Get the array of values out of the dictionary */
      NSMutableArray *thisSectionValues = 
      [thisSection valueForKey:@"Values"];
      
      if ([thisSectionValues count] > indexPath.row){
        result.textLabel.text = 
        [thisSectionValues objectAtIndex:indexPath.row];
      }
      
    }
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}


/* ------------------------------------------- */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSInteger result = 0;
  
  if ([tableView isEqual:self.myTableView] == YES){
    /* We just have one section */
    if (self.arrayOfSections != nil){
      result = [self.arrayOfSections count];
    }
  }
  
  return(result);
  
}

/* ------------------------------------------- */

- (UIView *)  tableView:(UITableView *)tableView 
 viewForFooterInSection:(NSInteger)section{
  
  UIView *result = nil;
  
  if ([tableView isEqual:self.myTableView] == YES){
    
    if (self.arrayOfSections != nil &&
        [self.arrayOfSections count] > section){
      
      NSMutableDictionary *thisSection = 
      [self.arrayOfSections objectAtIndex:section];
      
      NSString *footer = [thisSection objectForKey:@"Footer"];
      
      UILabel *myLabel = 
      [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
      
      myLabel.backgroundColor = [UIColor clearColor];
      myLabel.textAlignment = UITextAlignmentCenter;
      myLabel.font = [UIFont boldSystemFontOfSize:14.0f];
      myLabel.text = footer;
      result = myLabel;
      
    } /* if (self.arrayOfSections != nil && ... */
    
  } /* if ([tableView isEqual:self.myTableView] == YES){ */
  
  return(result);
  
}

/* ------------------------------------------- */

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  
//  /* Put strings in array that will later be feeding our table */
//  /* Create the array of sections */
//  
//  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//  self.arrayOfSections = mutableArray;
//  [mutableArray release];
//  
//  /* The first section with all its values */
//  NSMutableArray *section1 = [[NSMutableArray alloc] init];
//  [section1 addObject:@"Section 1 Cell 1"];
//  [section1 addObject:@"Section 1 Cell 2"];
//  [self.arrayOfSections addObject:section1];
//  [section1 release];
//  
//  /* The second section with all its values */
//  NSMutableArray *section2 = [[NSMutableArray alloc] init];
//  [section2 addObject:@"Section 2 Cell 1"];
//  [section2 addObject:@"Section 2 Cell 2"];
//  [self.arrayOfSections addObject:section2];
//  [section2 release];
//  
//  /* ------------- */
//  
//  UITableView *tableView = [[UITableView alloc] 
//                            initWithFrame:self.view.frame 
//                            style:UITableViewStyleGrouped];
//  
//  self.myTableView = tableView;
//  [tableView release];
//  
//  self.myTableView.autoresizingMask = 
//  UIViewAutoresizingFlexibleWidth | 
//  UIViewAutoresizingFlexibleHeight;
//  
//  [self.view addSubview:self.myTableView];
//  /* This View Controller is both the Data Source
//   and the Delegate of the Table View */
//  self.myTableView.dataSource = self;
//  self.myTableView.delegate = self;
//  
//}

/* ------------------------------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Create the array of sections */
  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
  self.arrayOfSections = mutableArray;
  [mutableArray release];
  
  /* The first section with all its values */
  NSMutableDictionary *section1 = [[NSMutableDictionary alloc] init];
  NSMutableArray *Section1Values = [[NSMutableArray alloc] init];
  [Section1Values addObject:@"Section 1 Cell 1"];
  [Section1Values addObject:@"Section 1 Cell 2"];
  [section1 setValue:@"Section 1 Header" forKey:@"Header"];
  [section1 setValue:@"Section 1 Footer" forKey:@"Footer"];
  [section1 setValue:Section1Values forKey:@"Values"];
  [self.arrayOfSections addObject:section1];
  [Section1Values release];
  [section1 release];
  
  NSMutableDictionary *section2 = [[NSMutableDictionary alloc] init];
  NSMutableArray *Section2Values = [[NSMutableArray alloc] init];
  [Section2Values addObject:@"Section 2 Cell 1"];
  [Section2Values addObject:@"Section 2 Cell 2"];
  [section2 setValue:@"Section 2 Header" forKey:@"Header"];
  [section2 setValue:@"Section 2 Footer" forKey:@"Footer"];
  [section2 setValue:Section2Values forKey:@"Values"];
  [self.arrayOfSections addObject:section2];
  [Section2Values release];
  [section2 release];
  
  UITableView *tableView = [[UITableView alloc] 
                            initWithFrame:self.view.frame 
                            style:UITableViewStyleGrouped];

  self.myTableView = tableView;
  [tableView release];
  
  self.myTableView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth | 
    UIViewAutoresizingFlexibleHeight;
  
  [self.view addSubview:self.myTableView];
  /* This View Controller is both the Data Source
   and the Delegate of the Table View */
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;
  
}

/* ------------------------------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
  
  self.myTableView = nil;
  self.arrayOfSections = nil;
  
}

/* ------------------------------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/* ------------------------------------------- */

- (void)dealloc {
  
  [myTableView release];
  [arrayOfSections release];
  [super dealloc];
}

/* ------------------------------------------- */

@end
