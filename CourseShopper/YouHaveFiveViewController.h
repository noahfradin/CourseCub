//
//  YouHaveFiveViewController.h
//  CourseShopper
//
//  Created by Alexander Meade on 12/10/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseViewController.h"
#import "Cart.h"

@interface YouHaveFiveViewController : UIViewController

@property UIView * buttonPane;

@property UIButton *yesButton;
@property UIButton *noButton;
@property CourseViewController * courseView;
@property UITextView * bookList;
@property NSMutableArray * buttons;
@property UILabel * cannotDrop;
@property Cart * currentCart;
@property UITextView * finalView;

@property UIButton *realYesButton;
@property UIButton *realNoButton;
@property NSInteger *tagged;
@property Course *courseInfo;
@property Course *courseToDrop;


-(void) showBlur;
-(void) cancelButtonWasPressed;


@end
