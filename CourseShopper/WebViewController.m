//
//  WebViewController.m
//  CourseShopper
//
//  Created by Alexander Meade on 12/3/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    
   

    
}



-(void)viewWillAppear:(BOOL)animated{
    //This gets rid of the text in the default back button
     self.navigationController.navigationBar.topItem.title = @"";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_currentUrl]]];
    [self.view addSubview: webView];
}

-(void)viewWillDisappear:(BOOL)animated{
    _courseView.navigationItem.title = _courseView.navTitle;
    _courseView.navigationController.title= _courseView.navTitle;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
