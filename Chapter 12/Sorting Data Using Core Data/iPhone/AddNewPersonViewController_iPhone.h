//
//  AddNewPersonViewController_iPhone.h
//  Data
//
//  Created by Vandad Nahavandipoor on 10-07-25.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Person.h"

/* ------------------------------------------- */

@interface AddNewPersonViewController_iPhone : UIViewController <UITextFieldDelegate> {
@public
  UITextField     *textFieldFirstName;
  UITextField     *textFieldLastName;
  UITextField     *textFieldAge;
  UIBarButtonItem *doneButton;
  UIBarButtonItem *saveButton;
}

/* ------------------------------------------- */

@property (nonatomic, retain) IBOutlet UITextField   *textFieldFirstName;
@property (nonatomic, retain) IBOutlet UITextField   *textFieldLastName;
@property (nonatomic, retain) IBOutlet UITextField   *textFieldAge;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *saveButton;

/* ------------------------------------------- */

- (void) setDefaultNavigationBarButtons;
- (void) setEditingModeNavigationBarButtons;

/* ------------------------------------------- */

@end
