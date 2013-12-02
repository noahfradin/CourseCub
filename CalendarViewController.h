//
//  CalendarViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController

@property NSMutableArray *course_title_array;

-(void) addButtonWasPressed;
-(void) menuButtonWasPressed;
-(void) courseButtonWasPressed:(UIButton*)sender;

@end
