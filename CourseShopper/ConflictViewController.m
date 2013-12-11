//
//  ConflictViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 12/11/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "ConflictViewController.h"
#import "CCCourseButton.h"
#import "Course.h"
#import "Department.h"
#import "CourseViewController.h"

@interface ConflictViewController ()

#define buttonPaneHeight self.view.frame.size.height*46/64
#define buttonPaneWidth self.view.frame.size.width*18/20
#define labelHeight buttonPaneHeight/10
#define offset buttonPaneHeight/30
#define textViewWidth buttonPaneWidth- 2*offset
#define textViewHeight buttonPaneHeight - 4*offset - 2*labelHeight
#define cancelHeight labelHeight

@end

@implementation ConflictViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _buttonPane = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/20,self.view.frame.size.height*9/64, self.view.frame.size.width*18/20,buttonPaneHeight)];
    UIColor *color = [UIColor grayColor];
    _buttonPane.backgroundColor = color;
    _buttonPane.alpha = .95f;
    [self.view addSubview:_buttonPane];
    
    UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    
    
    UILabel *bookListLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonPaneWidth, labelHeight)];
    bookListLabel.text = @"Course Conflict";
    UIColor *timeLabelFontColor = [UIColor whiteColor];
    bookListLabel.textAlignment = UITextAlignmentCenter;
    bookListLabel.textColor = timeLabelFontColor;
    bookListLabel.font = buttonFont;
    [_buttonPane addSubview: bookListLabel];
    
    
    UIFont *buttonFont2 = [UIFont fontWithName:@"Helvetica Light" size:20.0];
    
    int buttonHeight = 60;
    int buttonWidth = buttonPaneWidth;
    for (int i = 0; i<[self.conflictArray count]; i++) {
        Course *course = self.conflictArray[i];
        Department *department = course.department;
        CCCourseButton *courseButton = [[CCCourseButton alloc] initWithFrame:CGRectMake(0, offset + 50+buttonHeight*i, buttonWidth, buttonHeight)];
        [courseButton setBackgroundColor:department.color];
        courseButton.course = course;
        [courseButton setTitle:course.title forState:UIControlStateNormal];
        [courseButton addTarget:self action:@selector(alertCourseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonPane addSubview:courseButton];
    }
    
    
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset, textViewWidth, cancelHeight)];
    [cancel addTarget:self action:@selector(cancelButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.borderColor = [[UIColor whiteColor] CGColor];
    cancel.layer.borderWidth = 2;
    cancel.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[cancel titleLabel] setFont:buttonFont];
    [cancel setTitle:@"Cancel" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:cancel];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //This gets rid of the text in the default back button
    self.navigationController.navigationBar.topItem.title = @"";
    // [self captureBlur];
    self.view.alpha =0;
}

-(void)viewDidAppear:(BOOL)animated{
    [self showBlur];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) showBlur{
    [UIView animateWithDuration:.3 animations: ^{
        
        self.view.alpha=1;
    }];
    
}

-(void)cancelButtonWasPressed{
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.view.superview.subviews) {
        subView.userInteractionEnabled = YES;
    }
    [self.view removeFromSuperview];
    
    
}

-(void)alertCourseButtonWasPressed:(CCCourseButton *) sender{
    Course *course = sender.course;
    //Then instantiate the course detail view and set the title and the correct course
    //Anything else we need to pass can go here as well
    CourseViewController *courseView = [[CourseViewController alloc] init];
    courseView.courseTitle = course.title;
    courseView.course = course;
    courseView.currentCart = self.cart;
    
    NSString *abbrev = course.department.abbrev;
    NSString *abbrevNum = [abbrev stringByAppendingString:course.number];
    courseView.navigationItem.title = abbrevNum;
    courseView.abbrevNum = abbrevNum;
    courseView.departmentColor = course.department.color;
    
    [self presentViewController:courseView animated:YES completion:^{
        [self.view removeFromSuperview];
    }];
}


@end
