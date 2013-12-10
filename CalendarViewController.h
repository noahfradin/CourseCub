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

@interface CalendarViewController : UIViewController


@property NSMutableArray *course_title_array;
@property NSMutableArray *courseArray;

@property NSMutableDictionary *durationDict;
@property NSMutableDictionary *timeDict;
@property UIView *dayBar;

@property Cart *cart;

-(void) setCart:(Cart *)cart;
-(void) addButtonWasPressed;
-(void) menuButtonWasPressed;
-(void) courseButtonWasPressed:(UIButton*)sender;
-(void) loadData;
-(void)dayButtonWasPressed:(UIButton*)sender;



@end
