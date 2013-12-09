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
#import "CoursePreviewAlertViewController.h"
#import "CriticalReviewAlertViewController.h"
#import "RegisterAlertViewController.h"
#import "UnregisterAlertViewController.h"
#import "CourseAlertViewController.h"


@interface CourseViewController (){
    CourseAlertViewController * alert;
    CoursePreviewAlertViewController * coursePreview;
    CriticalReviewAlertViewController * criticalReview;
    UnregisterAlertViewController * unregisterAlert;
    RegisterAlertViewController * registerAlert;

    
}

@end

#define screenWidth self.view.bounds.size.width
#define screenHeight self.view.bounds.size.height
#define buttonHeight screenHeight/13
#define buttonSpacing 0
#define buttonWidth (screenWidth - buttonSpacing*2 )/3
#define textViewHeight screenHeight*28/64
#define textViewWidth screenWidth
#define registerButtonWidthOffset screenWidth * 45 /100
#define registerButtonHeightOffset screenHeight *98/256
#define dividingLines screenHeight/400
#define navLine screenHeight / 175
#define seatsOffset screenWidth/ 15
#define addToCart 1
#define notifyMe 2
#define stopNotify 3
#define registerRemove 4
#define registered 5


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
    UIColor *titleLabelFontColor = [UIColor colorWithRed:78.0f/255.0f green:77.0f/255.0f blue:79.0f/255.0f alpha:1];
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
    UIColor *timeLabelBackgroundColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    timeLabel.backgroundColor = timeLabelBackgroundColor;
    timeLabel.textColor = timeLabelFontColor;
    timeLabel.textAlignment = UITextAlignmentCenter;
    timeLabel.text = @"T R 1:00-2:30";
    [self.view addSubview:timeLabel];
    
    UILabel *professorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight*2.40, screenWidth, buttonHeight*3)];
    UIColor *professorLabelFontColor = [UIColor colorWithRed:153.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];;
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
    UIColor *locationLabelFontColor = [UIColor colorWithRed:153.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];
    UIFont *locationFont = [UIFont fontWithName:@"Helvetica Light" size:18.0];
    locationLabel.font = locationFont;
    locationLabel.textColor = locationLabelFontColor;
    locationLabel.textAlignment = UITextAlignmentCenter;
    locationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    locationLabel.numberOfLines = 0;
    locationLabel.text = @"Grant Recital Hall";
    [self.view addSubview:locationLabel];
    

    
    _totalSeats = arc4random() % 50;
    NSString *strFromInt2 = [NSString stringWithFormat:@"%d",_totalSeats];
    
    _seatsAvailable = arc4random() % _totalSeats;
    NSString *strFromInt = [NSString stringWithFormat:@"%d",_seatsAvailable];

    _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(seatsOffset, buttonHeight*4.3, screenWidth/3, buttonHeight*2)];
    UIColor *sizeLabelFontColor = [UIColor colorWithRed:153.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];
    UIFont *sizeLabelFont = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    _sizeLabel.font = sizeLabelFont;
    _sizeLabel.textColor = sizeLabelFontColor;
    _sizeLabel.textAlignment = UITextAlignmentCenter;
    _sizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _sizeLabel.numberOfLines = 0;
    NSString *seatsLeft = strFromInt;
    seatsLeft = [seatsLeft stringByAppendingString:@" / "];
    seatsLeft = [seatsLeft stringByAppendingString:strFromInt2];
    _sizeLabel.text = seatsLeft;
    _fractionLabel = seatsLeft;
    [self.view addSubview:_sizeLabel];
    
    _seatAvailableLabel = [[UILabel alloc] initWithFrame:CGRectMake(seatsOffset, buttonHeight*4.8, screenWidth/3, buttonHeight*2)];
    UIColor *seatAvailableFontColor = [UIColor colorWithRed:153.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];;
    UIFont *seatAvailableLabelFont = [UIFont fontWithName:@"Helvetica Light" size:12];
    _seatAvailableLabel.font = seatAvailableLabelFont;
    _seatAvailableLabel.textColor = seatAvailableFontColor;
    _seatAvailableLabel.textAlignment = UITextAlignmentCenter;
    _seatAvailableLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _seatAvailableLabel.numberOfLines = 0;
    _seatAvailableLabel.text = @"Seats Available";
    [self.view addSubview:_seatAvailableLabel];

    
  
    [self.view addSubview:_registerButton];
    
    
    self.view.opaque = NO; // Not really sure if needed
    self.view.backgroundColor = [UIColor clearColor]; // Be sure in fact that EVERY background in your view's hierarchy is totally or at least partially transparent for a kind effect!
    
    [self initButtonImage:_registerButton];
    [self initButtonImage2:_removeCartButton];
    

    _navBarDivide = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, screenWidth, navLine)];
    [_navBarDivide setBackgroundColor:_departmentColor];

    [self.navigationController.navigationBar addSubview:_navBarDivide];
    
    UIView *dividingLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenHeight*299/300)-buttonHeight-textViewHeight, screenWidth, dividingLines)];
    [dividingLine2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dividingLine2];
    
    UITextView *courseDetails = [[UITextView alloc] initWithFrame:CGRectMake(0, screenHeight-buttonHeight-textViewHeight, textViewWidth, textViewHeight)];
    courseDetails.alwaysBounceVertical = YES;
    courseDetails.editable = NO;
    courseDetails.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
                                       
    [self.view addSubview:courseDetails];
    
    UIView *dividingLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenHeight-dividingLines)-buttonHeight, screenWidth, dividingLines)];
    [dividingLine3 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dividingLine3];
    
    courseDetails.text = @"(most of the time) or used (rarely). Importantly, small defects (like creases or folds or dog ears, and even insufficient glue on the cover that a buyer can easily correct) do not qualify as defects that warrant returns. Inside the cover, the book text should be pristine—perfect. Ordering a few books together seems to be considerably cheaper on shipping costs than buying one book at a time. (You can see the costs of shipping different quantities on the order page.) I do not make any money on shipping. Our order page is just passing through the cost quoted by the shipping service. One final warning: shipwire tends to hold orders that do not have valid USPS addresses. So, shipping to the will not work. Make sure to enter a correct street address and zip code.(most of the time) or used (rarely). Importantly, small defects (like creases or folds or dog ears, and even insufficient glue on the cover that a buyer can easily correct) do not qualify as defects that warrant returns. Inside the cover, the book text should be pristine—perfect. Ordering a few books together seems to be considerably cheaper on shipping costs than buying one book at a time. (You can see the costs of shipping different quantities on the order page.) I do not make any money on shipping. Our order page is just passing through the cost quoted by the shipping service. One final warning: shipwire tends to hold orders that do not have valid USPS addresses. So, shipping to the will not work. Make sure to enter a correct street address and zip code.";
        

    

    
    UIColor *buttonFontColor = [UIColor blackColor];
    UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:14.0];

     _bookListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_bookListButton addTarget:self action:@selector(bookListButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_bookListButton setBackgroundColor:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];
     _bookListButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _bookListButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_bookListButton setTitle:@"Book\nList" forState: UIControlStateNormal];
     [_bookListButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     _bookListButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [[_bookListButton titleLabel] setFont:buttonFont];
    _bookListButton.layer.borderWidth = 1;
   
     [self.view addSubview:_bookListButton];
    
     _coursePreviewButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth+buttonSpacing, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_coursePreviewButton addTarget:self action:@selector(coursePreviewButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_coursePreviewButton setBackgroundColor:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];
     _coursePreviewButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _coursePreviewButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_coursePreviewButton setTitle:@"Course\nPreview" forState: UIControlStateNormal];
     [_coursePreviewButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     [[_coursePreviewButton titleLabel] setFont:buttonFont];
    _coursePreviewButton.layer.borderWidth = 1;

     [self.view addSubview:_coursePreviewButton];
   
    
    
     _criticalReviewButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*2+2*buttonSpacing, screenHeight-buttonHeight, buttonWidth,buttonHeight)];
     [_criticalReviewButton addTarget:self action:@selector(criticalReviewButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
     [_criticalReviewButton setBackgroundColor:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];
     _criticalReviewButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
     _criticalReviewButton.titleLabel.textAlignment = UITextAlignmentCenter;
     [_criticalReviewButton setTitle:@"Critical\nReview" forState: UIControlStateNormal];
     [_criticalReviewButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
     [[_criticalReviewButton titleLabel] setFont:buttonFont];
    _criticalReviewButton.layer.borderWidth = 1;

     [self.view addSubview:_criticalReviewButton];
    


	// Do any additional setup after loading the view.
}


-(void)registerButtonWasPressed{
    UIImage *btnImage;
    UIImage * btnImage2;
    if(_state == notifyMe){
          btnImage = [UIImage imageNamed:@"DoNotNotify"];
       
        _state = stopNotify;
        [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];

    }else if(_state == addToCart){
          btnImage = [UIImage imageNamed:@"RegisterHalf2"];
        _state = registerRemove;
        btnImage2 = [UIImage imageNamed:@"Remove2"];
        
        [_registerButton setFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
        
        [_removeCartButton setFrame:CGRectMake(registerButtonWidthOffset+85, registerButtonHeightOffset, btnImage2.size.width,btnImage2.size.height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        
        _registerButton.alpha = 0;
        _registerButton.alpha = 1;
        _removeCartButton.alpha = 0;
        _removeCartButton.alpha = 1;

        [self.view addSubview:_removeCartButton];
        
        
        
        [UIView commitAnimations];
        [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];

    }else if(_state == stopNotify){
          btnImage = [UIImage imageNamed:@"NotifyMe"];
        [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];

        _state = notifyMe;
    }else if(_state == registerRemove){
        registerAlert = [[RegisterAlertViewController alloc] init];
        registerAlert.courseView = self;
        [self.view addSubview:registerAlert.view];
        
    }else if(_state == registered){
        unregisterAlert = [[UnregisterAlertViewController alloc] init];
        unregisterAlert.courseView = self;
        [self.view addSubview:unregisterAlert.view];
        

    }else{
        NSLog( @"WTF?");
    }
   

}

-(void)registerRoll{
    UIImage *btnImage;
    UIImage * btnImage2;
    btnImage = [UIImage imageNamed:@"Unregister"];
    _sizeLabel.text = @"Registered";
    _seatAvailableLabel.text = @"";
    _state = registered;
    
    
    UIColor *sizeLabelFontColor = [UIColor colorWithRed:153/255 green:152/255 blue:152/255 alpha:1];
    UIFont *sizeLabelFont = [UIFont fontWithName:@"Helvetica Light" size:20.0];
    _sizeLabel.font = sizeLabelFont;
    
    
    
    [_registerButton setFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _registerButton.alpha = 0;
    _registerButton.alpha = 1;
    _sizeLabel.alpha = 0;
    _sizeLabel.alpha = 1;
    _seatAvailableLabel.alpha = 0;
    _seatAvailableLabel.alpha = 1;
    _sizeLabel.alpha = 0;
    _sizeLabel.alpha = 1;
    
    [UIView commitAnimations];
    
    [_removeCartButton removeFromSuperview];
    [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];
}

-(void)unregisterRoll{
    UIImage *btnImage;
    UIImage * btnImage2;
      btnImage = [UIImage imageNamed:@"RegisterHalf2"];
    _state = registerRemove;
    btnImage2 = [UIImage imageNamed:@"Remove2"];
    
    [_registerButton setFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    
    [_removeCartButton setFrame:CGRectMake(registerButtonWidthOffset+85, registerButtonHeightOffset, btnImage2.size.width,btnImage2.size.height)];
    [self.view addSubview:_removeCartButton];
    
    
    _seatAvailableLabel.text = @"Seats Available";
    _sizeLabel.text = _fractionLabel;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _registerButton.alpha = 0;
    _registerButton.alpha = 1;
    _removeCartButton.alpha = 0;
    _removeCartButton.alpha = 1;
    _seatAvailableLabel.alpha = 0;
    _seatAvailableLabel.alpha = 1;
    _sizeLabel.alpha = 0;
    _sizeLabel.alpha = 1;
    
    [UIView commitAnimations];
    
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
    coursePreview = [[CoursePreviewAlertViewController alloc] init];
    coursePreview.courseView = self;
    [self.view addSubview:coursePreview.view];
    
}

-(void)criticalReviewButtonWasPressed{
    criticalReview = [[CriticalReviewAlertViewController alloc] init];
    criticalReview.courseView = self;
    [self.view addSubview:criticalReview.view];
    
}

-(void)removeCartButtonWasPressed{
    UIImage *btnImage;
    UIImage *btnImage2;
    btnImage = [UIImage imageNamed:@"AddToCart"];
    _state = addToCart;
    
    [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [_registerButton setFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _registerButton.alpha = 0;
    _registerButton.alpha = 1;
    _removeCartButton.alpha = 0;
    
    
    
    [UIView commitAnimations];

    [_removeCartButton removeFromSuperview];

}

-(void)initButtonImage: UIBUtton{
    UIImage *btnImage;
    if(_seatsAvailable == 0) {
         NSLog(@"1");
        btnImage = [UIImage imageNamed:@"NotifyMe"];
        _state = notifyMe;
    }
    else{
         NSLog(@"2");
        btnImage = [UIImage imageNamed:@"AddToCart"];
        _state = addToCart;
        
    }
   
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    [_registerButton addTarget:self action:@selector(registerButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [_registerButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    _registerButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    _registerButton.layer.borderWidth = 1;
    [self.view addSubview:_registerButton];
}

-(void)initButtonImage2: UIBUtton{
    UIImage *btnImage;
    btnImage = [UIImage imageNamed:@"Remove2"];
    
    _removeCartButton = [[UIButton alloc] initWithFrame:CGRectMake(registerButtonWidthOffset, registerButtonHeightOffset, btnImage.size.width,btnImage.size.height)];
    [_removeCartButton addTarget:self action:@selector(removeCartButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    _removeCartButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    _removeCartButton.layer.borderWidth = 1;
    [_removeCartButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    
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
