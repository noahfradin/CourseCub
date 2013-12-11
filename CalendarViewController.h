//
//  CalendarViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"   
#import "CalendarMenuViewController.h"
#import "Cart.h"
#import "AppDelegate.h"

@interface CalendarViewController : UIViewController
@property AppDelegate *appDelegate;

@property NSMutableArray *course_title_array;
@property NSMutableArray *courseArray;

@property NSMutableDictionary *durationDict;
@property NSMutableDictionary *timeDict;
@property UIView *dayBar;

@property BOOL *is_first_time;

@property Cart *cart;

-(void) setCart:(Cart *)cart;
-(void) addButtonWasPressed;
-(void) menuButtonWasPressed;
-(void) courseButtonWasPressed:(UIButton*)sender;
-(void) loadData;
-(void)dayButtonWasPressed:(UIButton*)sender;
-(void)compileCourseInfo:(Course *) course;
-(void)addToCalendarView:(Course *) course;
-(void)addTitleToView:(Course *)course withCourseButton:(UIButton *)courseButton;

-(void)displayEmptyCartView;

@end
