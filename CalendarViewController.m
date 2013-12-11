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
#import "CCCourseButton.h"


@interface CalendarViewController (){
    double startTimeDouble;
    double endTimeDouble;
    NSInteger day;
    
    UIView *emptyCartView;
}

#define SCREEN_WIDTH 320
#warning set screen height conditionally based on model
#define SCREEN_HEIGHT 568 //iPhone 5 and up in future will set conditional based on phone type

#define DAY_WIDTH 61 // 64 = 320width/5days
#define HOUR_HEIGHT 47 // = 568height/12hours

#define TOPBAR_HEIGHT 64 //Statusbar height plus nav bar height w/out daybar
//Need to define sidebar and daybar width/height
#define DAYBAR_HEIGHT 34

#define HOUR_BLOCK 34
#define MINUTE_BLOCK .57

#define HOURS_TO_SHOW 12


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
-(void)viewDidAppear:(BOOL)animated{
    //Navbar stuff
    
    //Setting the title but in the future this will be dynamic based on chosen cart
    self.navigationItem.title = @"Da Best Cart";
    self.navigationItem.title = self.cart.title;
    NSLog(@"I'm here");
    //If we want to customize we'd just make this a normal button with a normal cgrect frame and add a button background
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonWasPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonWasPressed)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    ////////////////////////////////
    //Now for populating the calendar
    ///////////////////////////////
//    if (self.cart) {
        NSArray *cartArray = [self.cart getCartArray];
        if ([cartArray count]==0) {
            [self displayEmptyCartView];
        }

        else{
        [emptyCartView setHidden:YES];
        for (int i = 0; i<[cartArray count]; i++) {
            [self compileCourseInfo:cartArray[i]];
            [self addToCalendarView:cartArray[i]];
        }
        
    }
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
    
    NSArray *cartArray = [self.cart getCartArray];
//    if ([cartArray count]<2) {
//        [self displayEmptyCartView];
//    }
    //Initial configuration and data needs like array of day title strings
    
    self.dayBar = [[UIView alloc]initWithFrame:CGRectMake(0, TOPBAR_HEIGHT, SCREEN_WIDTH, DAYBAR_HEIGHT)];
    [self.dayBar setBackgroundColor:[UIColor whiteColor]];
    NSArray *dayInitials = [NSArray arrayWithObjects:@"M", @"T", @"W",@"TH",@"F", nil];
    
    //1px line at bottom of the bar
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, TOPBAR_HEIGHT+DAYBAR_HEIGHT, SCREEN_WIDTH, 1)];
//    [line setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:line];
    
    //Set up day buttons
    for (int j=0; j<5; j++) {
        //Initialize day button
        UIButton *dayButton = [[UIButton alloc]initWithFrame:CGRectMake(15+j*DAY_WIDTH, 0, DAY_WIDTH, DAYBAR_HEIGHT)];
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
    
//    [self loadData];
//    NSArray *cartArray = [self.cart getCartArray];
    for (int i = 0; i<[cartArray count]; i++) {
        
        
        [self compileCourseInfo:cartArray[i]];
        //Test data
        float startTime = 9.0+i*2;
        float duration = 1.0;
        float position = startTime - 9;
        float day = 0+i;
        //End of test/example data
        
        
//        if (day == 0||day==2||day==4) {
//            
//            for (int j = 0; j<4; j++) {
//                if (j== 0||j==2||j==4){
//                    UIButton *courseButton = [[UIButton alloc] initWithFrame:CGRectMake(day*DAY_WIDTH, position*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
//                    courseButton.tag = i;
//                    [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
//                    [courseButton setBackgroundColor:[UIColor grayColor]];
//                    [self.view addSubview:courseButton];
//                }
//            }
//        }
    }
    
    //Create and display timebar
    int hour_font_size = 12;
    UIView *timeBar = [[UIView alloc] initWithFrame:CGRectMake(0, DAYBAR_HEIGHT+TOPBAR_HEIGHT, 15, SCREEN_HEIGHT-34)];
    for (int i = 0; i<HOURS_TO_SHOW; i++) {
        UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i*HOUR_HEIGHT, timeBar.frame.size.width, hour_font_size+2)];
        int rawTime = i+8;
        int modTime = rawTime % 12;
        if (rawTime == 12) {
            modTime = 12;
        }
        [hourLabel setText:[NSString stringWithFormat:@"%i",modTime]];
        [hourLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:hour_font_size]];
        [timeBar addSubview:hourLabel];
    }
    [self.view addSubview:timeBar];
}
//
//-(void) setCart:(Cart *)cart{
//    self.cart = cart;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addButtonWasPressed{
    DepartmentTableViewController *addView = [[DepartmentTableViewController alloc] init];
    addView.cart = self.cart;
    [self.navigationController pushViewController:addView animated:YES];
}

-(void) menuButtonWasPressed{
    NSLog(@"Menubutton was tapped real nice");
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
    //Will present side menubar view here
}


//////////////////////////////////////////////////////////////////////
#pragma courseButtonWasPressed
//Takes a unique CCCoursebutton
//Passes all necessary course into to courseViewController and Pushes courseViewController
//////////////////////////////////////////////////////////////////////
-(void) courseButtonWasPressed:(CCCourseButton*)sender{
    
    if (sender.conflict) {
        NSLog(@"Conflict");
    }
    else{
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
        [self.navigationController pushViewController:courseView animated:YES];
    }
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
    
//    NSMutableArray course
    NSMutableArray *temp = [self.cart getCartArray];
    for (int i= 0; i<temp.count; i++) {
        Course *course = temp[i];
        [self.course_title_array addObject:course.title];
    }
    
}

-(NSInteger)numberToTime{
    return 0;
}

-(void)compileCourseInfo:(Course *) course{
    NSString *timeString = course.time;
    NSLog(course.time);
    if ([timeString hasPrefix:@"MWF"]) {
        day = 0;//Set day to MWF
        NSString *timeStringCopy = [NSString stringWithString:timeString];
        NSString *startTimeStringCopy = [NSString stringWithString:timeString];
        NSString *endTimeStringCopy = [NSString stringWithString:timeString];
//        timeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(4, 7)];
        NSLog(@"Monday/Wednesday/Friday");
        NSRange start = [timeStringCopy rangeOfString:@" "];
        NSRange end = [timeStringCopy rangeOfString:@"-"];
        if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
            startTimeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
            
        }
        startTimeDouble = [startTimeStringCopy doubleValue];
        NSLog(@"%li",(long)startTimeDouble);
        
        NSRange newstart = [timeStringCopy rangeOfString:@"-"];
        NSRange newend = [timeStringCopy rangeOfString:@"}"];
        if (newstart.location != NSNotFound && newend.location != NSNotFound && newend.location > newstart.location) {
            endTimeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(newstart.location+1, newend.location-(newstart.location+1))];
        }
        endTimeDouble = [endTimeStringCopy doubleValue];
        NSLog(@"%li",(long)endTimeDouble);
    }
    else if([timeString hasPrefix:@"TR"]){
        day = 1;
        NSString *timeStringCopy = [NSString stringWithString:timeString];
        NSString *startTimeStringCopy = [NSString stringWithString:timeString];
        NSString *endTimeStringCopy = [NSString stringWithString:timeString];
        //        timeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(4, 7)];
        NSLog(@"Tuesday/Thursday");
        NSRange start = [timeStringCopy rangeOfString:@" "];
        NSRange end = [timeStringCopy rangeOfString:@"-"];
        if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
            startTimeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
            
        }
        startTimeDouble = [startTimeStringCopy doubleValue];
        NSLog(@"%li",(long)startTimeDouble);
        
        NSRange newstart = [timeStringCopy rangeOfString:@"-"];
        NSRange newend = [timeStringCopy rangeOfString:@"}"];
        if (newstart.location != NSNotFound && newend.location != NSNotFound && newend.location > newstart.location) {
            endTimeStringCopy = [timeStringCopy substringWithRange:NSMakeRange(newstart.location+1, newend.location-(newstart.location+1))];
            
        }
        endTimeDouble = [endTimeStringCopy doubleValue];
        NSLog(@"%li",(long)endTimeDouble);
        
                
        NSLog(@"###################END%li", (long)startTimeDouble);
        NSLog(@"###################START%li", (long)endTimeDouble);
    }
}

-(void)addToCalendarView:(Course *) course{

    //Check for course conflict.. this is pretty primitive only matches exact time matches in future need to store actual start and end time with each course to compare for overlaps.. could run through array and parse but think we should add actual time numbers to course objects. Right now core data is optimized for display with strings.. thats silly.
    
    //If we changed the times to 24 hour clock we could just mod it everywhere else
    if (startTimeDouble < 8) {//Afternoon courses
        startTimeDouble = startTimeDouble +12;
    }
    if (endTimeDouble < 8) {//Afternoon courses
        endTimeDouble = endTimeDouble +12;
    }
    
    double duration = endTimeDouble - startTimeDouble;
    double startTime = startTimeDouble-8;//Start 8am classes at position 0
    UIColor *lightGrey= [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1]; /*#ecf0f1*/
    
    if (day == 0) {
        for (int i = 0; i<5; i++) {
            if (i == 0 || i==2 || i==4) {
                CCCourseButton *courseButton = [[CCCourseButton alloc] initWithFrame:CGRectMake(15+i*DAY_WIDTH, startTime*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
                [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
                [courseButton setBackgroundColor:lightGrey];
                
                //Create top color bumper
                [self addTitleToView:course withCourseButton:courseButton];
                [self.view addSubview:courseButton];
            }
        }
    }
    else if (day == 1) {
        for (int i = 0; i<5; i++) {
            if (i == 1 || i==3) {
                CCCourseButton *courseButton = [[CCCourseButton alloc] initWithFrame:CGRectMake(15+i*DAY_WIDTH, startTime*HOUR_HEIGHT+TOPBAR_HEIGHT+DAYBAR_HEIGHT, DAY_WIDTH, HOUR_HEIGHT*duration)];
                [courseButton addTarget:self action:@selector(courseButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
                [courseButton setBackgroundColor:lightGrey];
                
                //Create top color bumper
                [self addTitleToView:course withCourseButton:courseButton];
                [self.view addSubview:courseButton];
            }
        }
    }
    
    
    
}

-(void)addTitleToView:(Course *)course withCourseButton:(CCCourseButton *)courseButton{
    
    courseButton.course = course;//Set course property of course button
    courseButton.conflict = NO;
    courseButton.conflictArray = [[NSMutableArray alloc] init];;
    NSArray *cartArray = [self.cart getCartArray];
    for (int i = 0; i<[cartArray count]; i++) {
        Course *compCourse = cartArray[i];
        if ([compCourse.time isEqualToString:course.time]) {
            [courseButton.conflictArray addObject:compCourse];
        }
    }
    if ([courseButton.conflictArray count]>1) {
        courseButton.conflict = YES;
    }
    
        UIColor *darkGrey = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1]; /*#7f8c8d*/
        //Add course data to view
        //Start with title
    
    int small_font_size = 11;
    
        if (courseButton.conflict) {
            for (int i = 0; i<[courseButton.conflictArray count]; i++) {
                Course *c = courseButton.conflictArray[i];
                NSString *abbrev = c.department.abbrev;
                NSString *abbrevNum = [abbrev stringByAppendingString:c.number];
                UIColor *deptColor = c.department.color;
                
                UILabel *deptAbbrevLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 13+small_font_size*i, DAY_WIDTH, small_font_size+2)];
                [deptAbbrevLabel setText:abbrevNum];
                [deptAbbrevLabel setTextColor:darkGrey];
                [deptAbbrevLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:small_font_size]];
                [courseButton addSubview:deptAbbrevLabel];
            
                int color_bumper_width = DAY_WIDTH/[courseButton.conflictArray count];
                UIView *colorBumper = [[UIView alloc] initWithFrame:CGRectMake(color_bumper_width*i, 0, color_bumper_width, 10)];
                [colorBumper setBackgroundColor:deptColor];
                [courseButton addSubview:colorBumper];
            }
        }
        else{
            NSString *abbrev = course.department.abbrev;
            NSString *abbrevNum = course.number;
            UILabel *deptAbbrevLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 13, DAY_WIDTH, 15)];
            [deptAbbrevLabel setText:abbrev];
            [deptAbbrevLabel setTextColor:darkGrey];
            [deptAbbrevLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:16]];
            [courseButton addSubview:deptAbbrevLabel];
            
            UILabel *courseNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 28, DAY_WIDTH, 15)];
            [courseNumberLabel setText:abbrevNum];
            [courseNumberLabel setTextColor:darkGrey];
            [courseNumberLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:12]];
            [courseButton addSubview:courseNumberLabel];
            
            UIView *colorBumper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DAY_WIDTH, 10)];
            UIColor *deptColor = course.department.color;
            [colorBumper setBackgroundColor:deptColor];
            [courseButton addSubview:colorBumper];
        }
        
    
}

-(void)displayEmptyCartView{
     emptyCartView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [emptyCartView setBackgroundColor:[UIColor whiteColor]];
    
     UIColor *silver = [UIColor colorWithRed:0.741 green:0.765 blue:0.78 alpha:1]; /*#bdc3c7*/
    
    //Set header and add it
    UILabel *emptyHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50)];
    [emptyHeaderLabel setTextAlignment:NSTextAlignmentCenter];
    [emptyHeaderLabel setText:@"Empty Cart"];
    [emptyHeaderLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:25]];
    [emptyHeaderLabel setTextColor:silver];
    [emptyCartView addSubview:emptyHeaderLabel];
    [emptyCartView bringSubviewToFront:emptyHeaderLabel];
    
    //Set message and add it
    UILabel *emptyMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 30)];
    [emptyMessageLabel setTextAlignment:NSTextAlignmentCenter];
    [emptyMessageLabel setText:@"Courses you add to the cart will show up here"];
    [emptyMessageLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:15]];
    [emptyMessageLabel setTextColor:silver];
    [emptyCartView addSubview:emptyMessageLabel];
    
    UIImage *books = [UIImage imageNamed:@"book_stack"];
    UIImageView *booksImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 250, books.size.width, books.size.height)];
    [booksImageView setImage:books];
    [emptyCartView addSubview:booksImageView];
    
    [self.view addSubview:emptyCartView];
//    [self.view bringSubviewToFront:emptyCartView];
}

@end