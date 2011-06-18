//
//  LeftViewController.m
//  ViewsAndVC
//
//  Created by Vandad Nahavandipoor on 10-07-09.
//  Copyright 2010  All rights reserved.
//

#import "LeftViewController.h"

/* --------------------- */

@implementation LeftViewController

/* --------------------- */

@synthesize delegate;

/* --------------------- */

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  Protocol *neededProtocol = @protocol(LeftViewControllerDelegate);
  
  SEL neededSelector = 
    @selector(leftViewController:itemIsSelectedWithItemIndexPath:itemText:);
  
  if (self.delegate == nil ||
      [self.delegate conformsToProtocol:neededProtocol] == NO ||
      [self.delegate respondsToSelector:neededSelector] == NO){
    return;
  }

  UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
  [self.delegate leftViewController:self
    itemIsSelectedWithItemIndexPath:indexPath
                           itemText:selectedCell.textLabel.text];
  
}

/* --------------------- */

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
  return(1);
}

/* --------------------- */

- (NSInteger) tableView:(UITableView *)table 
  numberOfRowsInSection:(NSInteger)section{
  return(10);
}

/* --------------------- */

- (UITableViewCell*) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString *CellIdentifier = @"MyCellStyle";
  
  UITableViewCell *result = 
  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (result == nil){
    result = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier] autorelease];
  }
  
  result.textLabel.text = [NSString stringWithFormat:@"Item %lu", 
                           (unsigned long)indexPath.row];
  
  return(result);
  
}

/* --------------------- */

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = NSLocalizedString(@"Left View Controller", nil);
}

/* --------------------- */

- (void) viewDidUnload{
  [super viewDidUnload];
}

/* --------------------- */

- (BOOL)shouldAutorotateToInterfaceOrientation:
  (UIInterfaceOrientation)interfaceOrientation {
  return(YES);  
}

/* --------------------- */

- (void) dealloc{
  [super dealloc];
}

/* --------------------- */

@end

