//
//  LoginViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "LoginViewController.h"
#import "CalendarViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController (){
    UITextField *password;
}

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
    
    UIImage *logo = [UIImage imageNamed: (@"Logo")];
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 220.0, 300.0, 286.0)];
    logoView.image = logo;
    [self.view addSubview:logoView];
    
    UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 275, 38)];
    username.clearsOnBeginEditing = YES;
    [username setBorderStyle: UITextBorderStyleLine];
    [[username layer] setBorderColor:[[UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0] CGColor]];
    username.text = @" Username";
    username.textColor = [UIColor grayColor];
    username.tag = 1;
    username.delegate = self;
    [self.view addSubview:username];
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(20, 96, 275, 38)];
    password.clearsOnBeginEditing = YES;
    [password setBorderStyle: UITextBorderStyleLine];
    [[password layer] setBorderColor:[[UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0] CGColor]];
    password.text = @" Password";
    password.textColor = [UIColor grayColor];
    password.tag = 2;
    password.delegate = self;
    [self.view addSubview:password];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 142, 120, 38)];
    [loginButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [loginButton setBackgroundColor:[UIColor grayColor]];
    [loginButton addTarget:self action:@selector(loginButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.tag = 3;
    [self.view addSubview:loginButton];
}

-(void)loginButtonWasPressed{
//    CalendarViewController *cal = [[CalendarViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cal];
//    [navController.navigationBar setTintColor:[UIColor blackColor]];
//    [self presentViewController:navController animated:YES completion:nil];
    
    
    self.menuViewController = [[CalendarMenuViewController alloc] initWithNibName:nil bundle:nil];
    self.mainViewController = [[CalendarViewController alloc] initWithNibName:nil bundle:nil];
    
    self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController:[[UINavigationController alloc] initWithRootViewController:self.mainViewController]];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.5634f : 0.85f;
    
    [self presentViewController:self.sideMenuViewController animated:YES completion:nil];
//    self.window.rootViewController = self.sideMenuViewController;
//    
//    self.window.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [password setSecureTextEntry:YES];
    return YES;
}

@end
