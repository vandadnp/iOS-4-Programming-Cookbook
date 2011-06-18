//
//  ObjectsAppDelegate.m
//  Objects
//
//  Created by Vandad Nahavandipoor on 10-05-26.
//  Copyright  2010. All rights reserved.
//

#import "ObjectsAppDelegate.h"
#import "MyObject.h"

/* --------------------------------------------- */

@implementation ObjectsAppDelegate

/* --------------------------------------------- */

@synthesize window;

/* --------------------------------------------- */

- (void) log:(id)paramObject{
  
  NSLog(@"Object = %@", paramObject);
  
}

/* --------------------------------------------- */

- (void) logSelf{
  
  SEL methodToCall = @selector(log:);
  
  [self performSelector:methodToCall
             withObject:self];
  
}

/* --------------------------------------------- */

- (void) methodWithParam1:(NSString *)param1
                andParam2:(NSNumber *)param2{
  
  NSLog(@"Param 1 = %@", param1);
  NSLog(@"Param 2 = %@", param2);
  
}

/* --------------------------------------------- */

- (void) methodWithParam1:(NSString *)param1{
  
  /* This is the method with two parameters */
  SEL methodToCall = @selector(methodWithParam1:andParam2:);
  
  NSNumber *numberValue = [NSNumber numberWithInteger:123];
  
  /* Call the other method with two parameters */
  [self performSelector:methodToCall
             withObject:param1
             withObject:numberValue];
  
}

/* --------------------------------------------- */

- (void) paintTheWholeScreenWithWhiteColor{
  /* Do the painting here */
}

/* --------------------------------------------- */

- (void) drawPointAtPoint:(CGPoint)paramPoint{
  /* Do the drawing here */
}

/* --------------------------------------------- */

- (void) drawCircleWithCenterPoint:(CGPoint)paramCente
                         andRadius:(CGFloat)paramRadius{
  /* Draw the circle here */
}

/* --------------------------------------------- */

- (void) drawTriangleWithPoint1:(CGPoint)paramPoint1
                      andPoint2:(CGPoint)paramPoint2
                      andPoint3:(CGPoint)paramPoint3{
  /* Draw the triangle here */
}

/* --------------------------------------------- */

- (BOOL) sendEmailTo:(NSString *)paramTo 
         withSubject:(NSString *)paramSubject 
     andEmailMessage:(NSString *)paramEmailMessage{
  
  /* Send the email and return an appropriate value */
  
  if (paramTo == nil ||
      paramSubject == nil ||
      paramEmailMessage == nil){
    /* One or some of the parameters are nil */
    NSLog(@"Nil parameter(s) is/are provided.");
    return(NO);
  }
  
  return(YES);
  
}

/* --------------------------------------------- */

//void sendEmailTo(const char *paramTo, 
//                 const char *paramSubject, 
//                 const char *paramEmailMessage){
//  
//  /* send the email here ... */
//}

/* --------------------------------------------- */

BOOL sendEmailTo(const char *paramTo, 
                 const char *paramSubject, 
                 const char *paramEmailMessage){
  
  /* send the email here ... */
  
  if (paramTo == nil ||
      paramSubject == nil ||
      paramEmailMessage == nil){
    /* One or some of the parameters are nil */
    NSLog(@"Nil parameter(s) is/are provided.");
    return(NO);
  }
  
  return(YES);
}

/* --------------------------------------------- */

- (BOOL) sendEmailTo:(NSString *)paramTo 
                    :(NSString *)paramSubject 
                    :(NSString *)paramEmailMessage{
  
  /* Send the email and return an appropriate value */
  
  if (paramTo == nil ||
      paramSubject == nil ||
      paramEmailMessage == nil){
    /* One or some of the parameters are nil */
    NSLog(@"Nil parameter(s) is/are provided.");
    return(NO);
  }
  
  return(YES);
  
}

/* --------------------------------------------- */

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

  BOOL isSuccessful = sendEmailTo("somebody@somewhere.com", 
                                "My Subject", 
                                "Please read my email");
  
  if (isSuccessful == YES){
    /* Successfully sent the email */
  } else {
    /* Failed to send the email. Perhaps we should display
     an error message to the user */
  }
  
  /* Call the method */
  [self sendEmailTo:@"oreilly@oreilly.com"
        withSubject:@"Hi O'Reilly"
    andEmailMessage:@"This is my first email"];
  
  /* This will call the second method */
  [self sendEmailTo:@"oreilly@oreilly.com"
                   :@"Hi, again, O'Reilly"
                   :@"This is my second email"];
  
  [window makeKeyAndVisible];
	
	return YES;
}

/* --------------------------------------------- */

//- (BOOL)            application:(UIApplication *)application 
//  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
//	
//  SEL PaintScreen = @selector(paintTheWholeScreenWithWhiteColor);
//  SEL DrawPoint = @selector(drawPointAtPoint:);
//  SEL DrawCircle = @selector(drawCircleWithCenterPoint:andRadius:);
//  SEL DrawTriangle = @selector(drawTriangleWithPoint1:andPoint2:andPoint3:);
//  
//  /* Do something with these selectors. I'll simply
//   print them out to the console */
//  
//  NSLog(@"Paint Screen Selector = %@", NSStringFromSelector(PaintScreen));
//  NSLog(@"Draw Point Selector = %@", NSStringFromSelector(DrawPoint));
//  NSLog(@"Draw Circle Selector = %@", NSStringFromSelector(DrawCircle));
//  NSLog(@"Draw Triangle Selector = %@", NSStringFromSelector(DrawTriangle));
//  
//  [window makeKeyAndVisible];
//	
//	return YES;
//}

/* --------------------------------------------- */


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  [window release];
  [super dealloc];
}


@end
