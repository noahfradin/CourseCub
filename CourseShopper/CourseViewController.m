//
//  CourseViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CourseViewController.h"
#import "WebViewController.h"
#import "CourseAlertViewController.h"
#import <stdlib.h>
#import <time.h>


@interface CourseViewController (){
    CourseAlertViewController * alert;
}

@end

#define screenWidth self.view.bounds.size.width
#define screenHeight self.view.bounds.size.height
#define buttonHeight screenHeight/13
#define buttonSpacing screenWidth/100
#define buttonWidth (screenWidth - buttonSpacing*2 )/3
#define textViewHeight screenHeight*28/64
#define textViewWidth screenWidth
#define registerButtonWidthOffset screenWidth * 3 /5
#define registerButtonHeightOffset screenHeight *81/256
#define dividingLines screenHeight/400
#define navLine screenHeight / 175
#define seatsOffset screenWidth/ 15


@implementation CourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //This gets rid of the text in the default back button
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationItem.title = _navTitle;
    [_navBarDivide setHidden:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *courseTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight*3/4, screenWidth, buttonHeight*3)];
    UIColor *titleLabelFontColor = [UIColor blackColor];
    UIFont *titleFont = [UIFont fontWithName:@"Helvetica Light" size:18.0];
    courseTitleLabel.font = titleFont;
    courseTitleLabel.textColor = titleLabelFontColor;
    courseTitleLabel.textAlignment = UITextAlignmentCenter;
    courseTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    courseTitleLabel.numberOfLines = 0;
    courseTitleLabel.text = @"Seminar in Electronic Music:\n Real-Time Systems";
    [self.view addSubview:courseTitleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight*3, screenWidth, buttonHeight/2)];
    UIColor *timeLabelFontColor = [UIColor whiteColor];
    UIColor *timeLabelBackgroundColor = [UIColor grayColor];
    timeLabel.backgroundColor = timeLabelBackgroundColor;
    timeLabel.textColor = timeLabelFontColor;
    timeLabel.textAlignment = UITextAlignmentCenter;
    timeLabel.text = @"T R 1:00-2:30";
    [self.view addSubview:timeLabel];
    
    UILabel *professorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight*2.40, screenWidth, buttonHeight*3)];
    UIColor *professorLabelFontColor = [UIColor blackColor];
    UIFont *professorLabelFont = [UIFont fontWithName:@"Helvetica Light" size:18.0];
    professorLabel.font = professorLabelFont;
    professorLabel.textColor = professorLabelFontColor;
    professorLabel.textAlignment = UITextAlignmentCenter;
    professorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    professorLabel.numberOfLines = 0;
    NSString *profPrefix = @"Prof: ";
    profPrefix = [profPrefix stringByAppendingString:@"Dror Brener"];
    professorLabel.text = profPrefix ;
    [self.view addSubview:professorLabel];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight*2.92, screenWidth, buttonHeight*3)];
    UIColor *locationLabelFontColor = [UIColor blackColor];
    UIFont *locationFont = [UIFont fontWithName:@"Helvetica Light" size:18.0];
    locationLabel.font = locationFont;
    locationLabel.textColor = locationLabelFontColor;
    locationLabel.textAlignment = UITextAlignmentCenter;
    locationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    locationLabel.numberOfLines = 0;
    locationLabel.text = @"Grant Recital Hall";
    [self.view addSubview:locationLabel];
    
    int kidsInClass = arc4random() % 21;
    NSString *strFromInt = [NSString stringWithFormat:@"%d",kidsInClass];
    
    int seatsInClass = arc4random() % 999;
    NSString *strFromInt2 = [NSString stringWithFormat:@"%d",seatsInClass];
    
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(seatsOffset, buttonHeight*4.5, screenWidth/2, buttonHeight*2)];
    UIColor *sizeLabelFontColor = [UIColor blackColor];
    UIFont *sizeLabelFont = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    sizeLabel.font = sizeLabelFont;
    sizeLabel.textColor = sizeLabelFontColor;
    sizeLabel.textAlignment = UITextAlignmentCenter;
    sizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    sizeLabel.numberOfLines = 0;
    NSString *seatsLeft = strFromInt;
    seatsLeft = [seatsLeft stringByAppendingString:@" / "];
    seatsLeft = [seatsLeft stringByAppendingString:strFromInt2];
    sizeLabel.text = seatsLeft;
    NSLog(seatsLeft);
    [self.view addSubview:sizeLabel];

    
        UIImage *btnImage = [UIImage imageNamed:@"AddToCart"];
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    [_registerButton addTarget:self action:@selector(registerButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];

    [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.view addSubview:_registerButton];
    
    
    self.view.opaque = NO; // Not really sure if needed
    self.view.backgroundColor = [UIColor clearColor]; // Be sure in fact that EVERY background in your view's hierarchy is totally or at least partially transparent for a kind effect!
    
   

    _navBarDivide = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, screenWidth, navLine)];
    [_navBarDivide setBackgroundColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar addSubview:_navBarDivide];
    
    UIView *dividingLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenHeight*299/300)-buttonHeight-textViewHeight, screenWidth, dividingLines)];
    [dividingLine2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dividingLine2];
    
    UITextView *courseDetails = [[UITextView alloc] initWithFrame:CGRectMake(0, screenHeight-buttonHeight-textViewHeight, textViewWidth, textViewHeight)];
    courseDetails.alwaysBounceVertical = YES;
    courseDetails.editable = NO;
    [self.view addSubview:courseDetails];
    
    UIView *dividingLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenHeight-dividingLines)-buttonHeight, screenWidth, dividingLines)];
    [dividingLine3 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dividingLine3];
    
    courseDetails.text = @"(most of the time) or used (rarely). Importantly, small defects (like creases or folds or dog ears, and even insufficient glue on the cover that a buyer can easily correct) do not qualify as defects that warrant returns. Inside the cover, the book text should be pristine—perfect. Ordering a few books together seems to be considerably cheaper on shipping costs than buying one book at a time. (You can see the costs of shipping different quantities on the order page.) I do not make any money on shipping. Our order page is just passing through the cost quoted by the shipping service. One final warning: shipwire tends to hold orders that do not have valid USPS addresses. So, shipping to the will not work. Make sure to enter a correct street address and zip code.(most of the time) or used (rarely). Importantly, small defects (like creases or folds or dog ears, and even insufficient glue on the cover that a buyer can easily correct) do not qualify as defects that warrant returns. Inside the cover, the book text should be pristine—perfect. Ordering a few books together seems to be considerably cheaper on shipping costs than buying one book at a time. (You can see the costs of shipping different quantities on the order page.) I do not make any money on shipping. Our order page is just passing through the cost quoted by the shipping service. One final warning: shipwire tends to hold orders that do not have valid USPS addresses. So, shipping to the will not work. Make sure to enter a correct street address and zip code.";
        

    

    
    UIColor *buttonFontColor = [UIColor blackColor];
    UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:14.0];

     _bookListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_bookListButton addTarget:self action:@selector(bookListButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_bookListButton setBackgroundColor:[UIColor yellowColor]];
     _bookListButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _bookListButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_bookListButton setTitle:@"Book\nList" forState: UIControlStateNormal];
     [_bookListButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     _bookListButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [[_bookListButton titleLabel] setFont:buttonFont];
     [self.view addSubview:_bookListButton];
    
     _coursePreviewButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth+buttonSpacing, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_coursePreviewButton addTarget:self action:@selector(coursePreviewButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_coursePreviewButton setBackgroundColor:[UIColor yellowColor]];
     _coursePreviewButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _coursePreviewButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_coursePreviewButton setTitle:@"Course\nPreview" forState: UIControlStateNormal];
     [_coursePreviewButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     [[_coursePreviewButton titleLabel] setFont:buttonFont];
     [self.view addSubview:_coursePreviewButton];
   
    
    
     _criticalReviewButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*2+2*buttonSpacing, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_criticalReviewButton addTarget:self action:@selector(criticalReviewButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_criticalReviewButton setBackgroundColor:[UIColor yellowColor]];
     _criticalReviewButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _criticalReviewButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_criticalReviewButton setTitle:@"Critical\nReview" forState: UIControlStateNormal];
     [_criticalReviewButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     [[_criticalReviewButton titleLabel] setFont:buttonFont];
     [self.view addSubview:_criticalReviewButton];
    


	// Do any additional setup after loading the view.
}


-(void)registerButtonWasPressed{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT!! AHHHH" message:@"Whoah!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    [alert show];
    
}

-(void)bookListButtonWasPressed{
    alert = [[CourseAlertViewController alloc] init];
  //  self.view.userInteractionEnabled = NO;
   // self.navigationController.view.userInteractionEnabled = NO;
    //_criticalReviewButton.userInteractionEnabled = NO;
   // _coursePreviewButton.userInteractionEnabled = NO;
   // _registerButton.userInteractionEnabled = NO;
   // _bookListButton.userInteractionEnabled = NO;

    //alertView.details = self;
    [self.view addSubview:alert.view];
    

}

-(void)coursePreviewButtonWasPressed{
    WebViewController *coursePreview = [[WebViewController alloc] init];
    coursePreview.currentUrl = @"http://www.thecriticalreview.org/";
    coursePreview.courseView = self;
    coursePreview.navigationItem.title = @"Critical Review";
    [self.navigationController pushViewController:coursePreview animated:YES];
    
}

-(void)criticalReviewButtonWasPressed{
    WebViewController *criticalReview = [[WebViewController alloc] init];
    criticalReview.currentUrl =@"http://courses.brown.edu/";
    criticalReview.courseView = self;
    criticalReview.navigationItem.title = @"Course Preview";
    [self.navigationController pushViewController:criticalReview animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [_navBarDivide setHidden:YES];
}

@end
