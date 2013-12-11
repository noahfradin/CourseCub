//
//  ConflictViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 12/11/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCourseButton.h"
#import "Cart.h"

@interface ConflictViewController : UIViewController

//@property CourseViewController * details;
@property UIView * buttonPane;

@property UIButton *cancel;

@property NSArray *conflictArray;

@property Cart *cart;


-(void) showBlur;
-(void) cancelButtonWasPressed;
-(void)alertCourseButtonWasPressed:(CCCourseButton *) sender;

@end
