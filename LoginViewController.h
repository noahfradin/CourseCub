//
//  LoginViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"
#import "CalendarMenuViewController.h"
#import "CalendarViewController.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) CalendarMenuViewController *menuViewController;
@property (nonatomic, strong) CalendarViewController *mainViewController;

@property AppDelegate *appDelegate;

-(void)loginButtonWasPressed;



@end
