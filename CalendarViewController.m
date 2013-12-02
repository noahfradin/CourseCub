//
//  CalendarViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CalendarViewController.h"
#import "DepartmentTableViewController.h"
#import "CourseViewController.h"

@interface CalendarViewController ()

#define DAY_WIDTH 64 // = 320width/5days
#define HOUR_HEIGHT 47 // = 568height/12hours
#define TOPBAR_HEIGHT 64 //Statusbar height plus nav bar height w/out daybar
//Need to define sidebar and daybar width/height

@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//So we can do stuff in this method you want to happen preload.. good place to put navbar stuff
-(void)viewWillAppear:(BOOL)animated{
    //Navbar stuff
    
    //Setting the title but in the future this will be dynamic based on chosen cart
    self.navigationItem.title = @"Da Best Cart";
    
    //If we want to customize we'd just make this a normal button with a normal cgrect frame and add a button background
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonWasPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonWasPressed)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
}

//And this is a place for post view load stuff anything happening on the main view is cool to put here usually
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.course_title_array =[NSMutableArray arrayWithObjects:@"Africana Studies", @"Compuer Science", @"Fradin Studies",@"Advanced Fradin Studies",@"Intro to Fradin Studies", nil];
    
    for (int i = 0; i<self.course_title_array.count; i++) {
        
        //Test data
        float startTime = 9.0+i*2;
        float duration = 1.0;
        float position = startTime - 9;
        float day = 0+i;
        //End of test/example data
        
        UIButton *courseButton = [[UIButton alloc] initWithFrame:CGRectMake(day*DAY_WIDTH, position*HOUR_HEIGHT+TOPBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
        courseButton.tag = i;
        [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [courseButton setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:courseButton];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addButtonWasPressed{
    DepartmentTableViewController *addView = [[DepartmentTableViewController alloc] init];
    [self.navigationController pushViewController:addView animated:YES];
}

-(void) menuButtonWasPressed{
    NSLog(@"Menubutton was tapped real nice");
    //Will present side menubar view here
}

//////////////////////////////////////////////////////////////////////
#pragma courseButtonWasPressed
//Takes a unique index of course (courseIndex)
//Passes all necessary course into to courseViewController and Pushes courseViewController
//////////////////////////////////////////////////////////////////////
-(void) courseButtonWasPressed:(UIButton*)sender{
    NSString *courseTitle = self.course_title_array[sender.tag];
    //Then instantiate the course detail view and set the title to the correct course
    //Anything else we need to pass can go here as well
    CourseViewController *courseView = [[CourseViewController alloc] init];
    courseView.navigationItem.title = courseTitle;
    [self.navigationController pushViewController:courseView animated:YES];
    
}

@end
