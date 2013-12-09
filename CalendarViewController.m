//
//  CalendarViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CalendarViewController.h"
#import "DepartmentTableViewController.h"
#import "TWTSideMenuViewController.h"
#import "CourseViewController.h"


@interface CalendarViewController ()

#define SCREEN_WIDTH 320
#warning set screen height conditionally based on model
#define SCREEN_HEIGHT 568 //iPhone 5 and up in future will set conditional based on phone type

#define DAY_WIDTH 64 // = 320width/5days
#define HOUR_HEIGHT 47 // = 568height/12hours

#define TOPBAR_HEIGHT 64 //Statusbar height plus nav bar height w/out daybar
//Need to define sidebar and daybar width/height
#define DAYBAR_HEIGHT 34

#define HOUR_BLOCK 34
#define MINUTE_BLOCK .57


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
    
    /////////////////////////////////////////////////////////
    //General structural setup and enable for menu controller
    /////////////////////////////////////////////////////////
    //Set the background color to white to hide hidden views
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Add swipe gesture recognizer to menu
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonWasPressed)];
    
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    //////////////////////
    //Setup and add dayBar
    //////////////////////
    
    //Initial configuration and data needs like array of day title strings
    self.dayBar = [[UIView alloc]initWithFrame:CGRectMake(0, TOPBAR_HEIGHT, SCREEN_WIDTH, DAYBAR_HEIGHT)];
    [self.dayBar setBackgroundColor:[UIColor whiteColor]];
    NSArray *dayInitials = [NSArray arrayWithObjects:@"M", @"T", @"W",@"TH",@"F", nil];
    
    //1px line at bottom of the bar
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, TOPBAR_HEIGHT+DAYBAR_HEIGHT, SCREEN_WIDTH, 1)];
    [line setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:line];
    
    //Set up day buttons
    for (int j=0; j<5; j++) {
        //Initialize day button
        UIButton *dayButton = [[UIButton alloc]initWithFrame:CGRectMake(j*DAY_WIDTH, 0, DAY_WIDTH, DAYBAR_HEIGHT)];
        [dayButton setBackgroundColor:[UIColor whiteColor]];
        dayButton.tag = j;
        [dayButton addTarget:self action:@selector(dayButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //Day label for button
        NSString *dayInitial = [dayInitials objectAtIndex:j];
        UILabel *dayInitialLabel = [[UILabel alloc] initWithFrame:CGRectMake(DAY_WIDTH/2-8, 0, DAY_WIDTH, DAYBAR_HEIGHT)];//8 is an offset to visually center text
        [dayInitialLabel setText:dayInitial];
        [dayInitialLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:17]];
        
        //Add day label to day button and daybutton to daybar
        [dayButton addSubview:dayInitialLabel];
        [self.dayBar addSubview:dayButton];
    }
    
    [self.view addSubview:self.dayBar];
    
    
    ////////////////////////////////
    //Now for populating the calendar
    ///////////////////////////////
    
    [self loadData];
    
    for (int i = 0; i<self.course_title_array.count; i++) {
        
        //Test data
        float startTime = 9.0+i*2;
        float duration = 1.0;
        float position = startTime - 9;
        float day = 0+i;
        //End of test/example data
        
        
        if (day == 0||day==2||day==4) {
            
            for (int j = 0; j<4; j++) {
                if (j== 0||j==2||j==4){
                    UIButton *courseButton = [[UIButton alloc] initWithFrame:CGRectMake(day*DAY_WIDTH, position*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
                    courseButton.tag = i;
                    [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [courseButton setBackgroundColor:[UIColor grayColor]];
                    [self.view addSubview:courseButton];
                }
            }
//            UIButton *courseButton = [[UIButton alloc] initWithFrame:CGRectMake(day*DAY_WIDTH, position*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
//            courseButton.tag = i;
//            [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
//            [courseButton setBackgroundColor:[UIColor grayColor]];
//            
//            //Create top color bumper
//            
//            [self.view addSubview:courseButton];
        }
        UIButton *courseButton = [[UIButton alloc] initWithFrame:CGRectMake(day*DAY_WIDTH, position*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
        courseButton.tag = i;
        [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [courseButton setBackgroundColor:[UIColor grayColor]];
        
        //Create top color bumper
        
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
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
    //Will present side menubar view here
}


//////////////////////////////////////////////////////////////////////
#pragma courseButtonWasPressed
//Takes a unique index of course (sender.tag)
//Passes all necessary course into to courseViewController and Pushes courseViewController
//////////////////////////////////////////////////////////////////////
-(void) courseButtonWasPressed:(UIButton*)sender{
    NSString *courseTitle = self.course_title_array[sender.tag];
    //Then instantiate the course detail view and set the title to the correct course
    //Anything else we need to pass can go here as well
    CourseViewController *courseView = [[CourseViewController alloc] init];
    courseView.courseTitle = courseTitle;
    [self.navigationController pushViewController:courseView animated:YES];
}

//////////////////////////////////////////////////////////////////////
#pragma dayButtonWasPressed
//Takes a numbe day of week 0-4 (sender.tag)
//Displays single day calendar and animates initial to full day name
//////////////////////////////////////////////////////////////////////
-(void)dayButtonWasPressed:(UIButton*)sender{
    NSLog(@"dayButtonWasPressed");
    
    //Hide all other buttons
    UIView *whiteOut = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DAYBAR_HEIGHT)];
    [whiteOut setBackgroundColor:[UIColor whiteColor]];
    [self.dayBar addSubview:whiteOut];
    [self.dayBar bringSubviewToFront:whiteOut];
    [self.dayBar bringSubviewToFront:sender];
    
    //Animate movement of day initial to left of dayBar
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{[sender setFrame:CGRectMake(0, 0, SCREEN_WIDTH, DAYBAR_HEIGHT)];} completion:^(BOOL finished){
        //Complete day title here based on day array yet to be constructed
        UILabel *fullDayLabel = [[UILabel alloc] init];
        [fullDayLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:17]];
        float offset = 0;
        switch (sender.tag) {
            case 0:
                offset = 6;
                [fullDayLabel setText:@"ONDAY"];
                break;
            case 1:
                offset = 1;
                [fullDayLabel setText:@"UESDAY"];
                break;
            case 2:
                offset = 7;
                [fullDayLabel setText:@"EDNESDAY"];
                break;
            case 3:
                offset = 13;
                [fullDayLabel setText:@"URSDAY"];
                break;
            case 4:
                offset = 2;
                [fullDayLabel setText:@"RIDAY"];
                break;
                
            default:
                break;
        }
        
        [fullDayLabel setFrame:CGRectMake(DAY_WIDTH/2+offset, 0, SCREEN_WIDTH, DAYBAR_HEIGHT)];
        [sender addSubview:fullDayLabel];
        
    }];
    
#warning Still need to add back button and get rid of add and menu buttons in nav bar
    
    
}

-(void)loadData{
    self.course_title_array =[NSMutableArray arrayWithObjects:@"Africana Studies", @"Compuer Science", @"Fradin Studies",@"Advanced Fradin Studies",@"Intro to Fradin Studies", nil];
    
}

-(NSInteger)numberToTime{
    return 0;
}

@end