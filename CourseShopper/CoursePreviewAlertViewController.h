//
//  CoursePreviewAlertViewController.h
//  CourseShopper
//
//  Created by Alexander Meade on 12/5/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CourseViewController.h"

@interface CoursePreviewAlertViewController : UIViewController

@property UIView * buttonPane;

@property UIButton *yesButton;
@property UIButton *noButton;
@property CourseViewController * courseView;


-(void) showBlur;
-(void) cancelButtonWasPressed;

@end
