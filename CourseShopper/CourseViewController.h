//
//  CourseViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseAlertViewController.h"

@interface CourseViewController : UIViewController <UIAlertViewDelegate, UIWebViewDelegate>

@property(readwrite,strong) UIButton *registerButton;
@property(readwrite,strong) UIButton *coursePreviewButton;
@property(readwrite,strong) UIButton *bookListButton;
@property(readwrite,strong) UIButton *criticalReviewButton;
@property UIView *navBarDivide;
@property NSString *navTitle;
@property NSString *courseTitle;
@property NSString *professor;
@property NSString *location;


-(void)registerButtonWasPressed;
-(void)bookListButtonWasPressed;
-(void)coursePreviewButtonWasPressed;
-(void)criticalReviewButtonWasPressed;


@end
