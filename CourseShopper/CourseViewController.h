//
//  CourseViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"
#import "cart.h"

@interface CourseViewController : UIViewController <UIAlertViewDelegate, UIWebViewDelegate>

@property(readwrite,strong) UIButton *registerButton;
@property(readwrite,strong) UIButton *removeCartButton;
@property(readwrite,strong) UIButton *coursePreviewButton;
@property(readwrite,strong) UIButton *bookListButton;
@property(readwrite,strong) UIButton *criticalReviewButton;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property Course *courseInfo;

@property UIView *navBarDivide;
@property NSString *navTitle;
@property NSString *courseTitle;
@property NSString *abbrevNum;

@property UIColor *departmentColor;

@property NSString *professor;
@property NSString *location;
@property int seatsAvailable;
@property int totalSeats;
@property int state;
@property UILabel * sizeLabel;
@property UILabel * seatAvailableLabel;

@property NSString * fractionLabel;
@property Course *course;
@property Cart *currentCart;
@property NSMutableArray *registeredCourses;


-(void)registerButtonWasPressed;
-(void)bookListButtonWasPressed;
-(void)coursePreviewButtonWasPressed;
-(void)criticalReviewButtonWasPressed;
-(void)initButtonImage: UIBUtton;
-(void)unregisterRoll;
-(void)registerRoll;

@end
