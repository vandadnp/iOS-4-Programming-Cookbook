//
//  RootViewController_iPhone.h
//  Test
//
//  Created by Vandad Nahavandipoor on 10-07-28.
//  Copyright 2010  All rights reserved.
//

#import <UIKit/UIKit.h>

/* ----------------------------------- */

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

/* ----------------------------------- */

@interface RootViewController_iPhone : UIViewController 
                                       <EKEventEditViewDelegate> {
@public
  EKEventStore  *eventStore;
}

/* ----------------------------------- */

@property (nonatomic, retain) EKEventStore  *eventStore;

/* ----------------------------------- */

@end