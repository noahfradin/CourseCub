//
//  CourseAlertViewController.h
//  CourseShopper
//
//  Created by Alexander Meade on 11/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseViewController.h"

@interface CourseAlertViewController : UIViewController

//@property CourseViewController * details;
@property UIView * buttonPane;

@property UIButton *cancel;


-(void) showBlur;
-(void) cancelButtonWasPressed;


@end
