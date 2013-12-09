//
//  CriticalReviewAlertViewController.m
//  CourseShopper
//
//  Created by Alexander Meade on 12/5/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CriticalReviewAlertViewController.h"
#import "WebViewController.h";

#define buttonPaneHeight self.view.frame.size.height*46/64
#define buttonPaneWidth self.view.frame.size.width*18/20
#define labelHeight buttonPaneHeight/10
#define offset buttonPaneHeight/30
#define textViewWidth buttonPaneWidth- 2*offset
#define textViewHeight buttonPaneHeight - 4*offset - 2*labelHeight
#define cancelHeight labelHeight

@interface CriticalReviewAlertViewController ()

@end

@implementation CriticalReviewAlertViewController

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
    
    UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:30.0];
    
    
    UILabel *bookListLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonPaneWidth, labelHeight*4)];

    UIColor *timeLabelFontColor = [UIColor whiteColor];
    bookListLabel.textAlignment = UITextAlignmentCenter;
    bookListLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bookListLabel.numberOfLines = 0;
    bookListLabel.text = @"Are you okay with navigating to the\nCritical Review?";
    bookListLabel.textColor = timeLabelFontColor;
    bookListLabel.font = buttonFont;
    [_buttonPane addSubview: bookListLabel];
    
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset - 3.5*cancelHeight, textViewWidth, cancelHeight)];
    [yesButton addTarget:self action:@selector(yesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    yesButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    yesButton.layer.borderWidth = 2;
    yesButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[yesButton titleLabel] setFont:buttonFont];
    [yesButton setTitle:@"Yes" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:yesButton];
    
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset - 2*cancelHeight, textViewWidth, cancelHeight)];
    [noButton addTarget:self action:@selector(noButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    noButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    noButton.layer.borderWidth = 2;
    noButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[noButton titleLabel] setFont:buttonFont];
    [noButton setTitle:@"No" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:noButton];


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

-(void)yesButtonWasPressed{
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.view.superview.subviews) {
        subView.userInteractionEnabled = YES;
    }
    [self.view removeFromSuperview];
    
    WebViewController *criticalReview = [[WebViewController alloc] init];
    criticalReview.currentUrl =@"http://www.thecriticalreview.org/";
    criticalReview.courseView = _courseView;
    criticalReview.navigationItem.title = @"Critical Review";
    [_courseView.navigationController pushViewController:criticalReview animated:YES];

    [self.view removeFromSuperview];
    
}

-(void)noButtonWasPressed{
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.view.superview.subviews) {
        subView.userInteractionEnabled = YES;
    }
    [self.view removeFromSuperview];
    
    
}
@end
