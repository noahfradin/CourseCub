//
//  LoginViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "LoginViewController.h"
#import "CalendarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, 320, 50)];
    [loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton addTarget:self action:@selector(loginButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

-(void)loginButtonWasPressed{
    CalendarViewController *cal = [[CalendarViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cal];
    [navController.navigationBar setTintColor:[UIColor blackColor]];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
