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

@interface CalendarViewController ()

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
    
    //Set the background color to white to hide hidden views
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //I just put this here to show us where we are for now
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 200)];
    test.text = @"Yo so this is the calview :}";
    [self.view addSubview:test];
    //End of example text
    
    //Add swipe gesture recognizer to menu
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonWasPressed)];
    
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
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

-(void)loadData{
    self.courseArray = [NSMutableArray arrayWithObjects:@"Africana Studies", @"Compuer Science", @"Fradin Studies", nil];
}

-(NSInteger)numberToTime{
    return 0;
}

@end
