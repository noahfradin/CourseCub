//
//  YouHaveFiveViewController.m
//  CourseShopper
//
//  Created by Alexander Meade on 12/10/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "YouHaveFiveViewController.h"
#import "Department.h"
#import "Course.h"
#import "CustumUI.h"


#define buttonPaneHeight self.view.frame.size.height*46/64
#define buttonPaneWidth self.view.frame.size.width*18/20
#define labelHeight buttonPaneHeight/10
#define offset buttonPaneHeight/30
#define textViewWidth buttonPaneWidth- 2*offset
#define textViewHeight buttonPaneHeight - 4*offset - 2*labelHeight
#define cancelHeight labelHeight



@interface YouHaveFiveViewController ()

@end

@implementation YouHaveFiveViewController


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
    _buttons = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
    _buttonPane = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/20,self.view.frame.size.height*9/64, self.view.frame.size.width*18/20,buttonPaneHeight)];
    UIColor *color = [UIColor grayColor];
    _buttonPane.backgroundColor = color;
    _buttonPane.alpha = .95f;
    [self.view addSubview:_buttonPane];
    
     UIFont *buttonFont0 = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:18.0];
    UIFont *buttonFont3 = [UIFont fontWithName:@"Helvetica Light" size:20.0];
    
    
    _cannotDrop = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonPaneWidth, labelHeight)];
    UIColor *timeLabelFontColor = [UIColor whiteColor];
    _cannotDrop.textAlignment = UITextAlignmentCenter;
    _cannotDrop.lineBreakMode = NSLineBreakByWordWrapping;
    _cannotDrop.numberOfLines = 0;
    _cannotDrop.text = @"Cannot Register";
    _cannotDrop.textColor = timeLabelFontColor;
    _cannotDrop.font = buttonFont0;
    [_buttonPane addSubview: _cannotDrop];
    
    
    UIFont *buttonFont2 = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    
   _bookList = [[UITextView alloc] initWithFrame:CGRectMake(offset, labelHeight+offset*2.3, textViewWidth, cancelHeight*5.25)];
    _bookList.layer.borderColor = [[UIColor whiteColor] CGColor];
    _bookList.layer.backgroundColor = [[UIColor grayColor] CGColor];
    _bookList.font = buttonFont3;
    _bookList.layer.borderWidth = 2;
    _bookList.alwaysBounceVertical = YES;
    _bookList.editable = NO;
    _bookList.textColor = timeLabelFontColor;
    _bookList.textAlignment = UITextAlignmentCenter;
    _bookList.text = @"\n\n\n\nYou are already registered\nfor five classes";
    
    [_buttonPane addSubview:_bookList];
    
    
    
   
    
    _finalView = [[UITextView alloc] initWithFrame:CGRectMake(offset, labelHeight+offset*2.3, textViewWidth, cancelHeight*5.25)];
    _finalView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _finalView.layer.backgroundColor = [[UIColor grayColor] CGColor];
    _finalView.font = buttonFont3;
    _finalView.layer.borderWidth = 2;
    _finalView.alwaysBounceVertical = YES;
    _finalView.editable = NO;
    _finalView.textColor = timeLabelFontColor;
    _finalView.textAlignment = UITextAlignmentCenter;

    
    
    
    _yesButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset - cancelHeight -15, textViewWidth, cancelHeight)];
    [_yesButton addTarget:self action:@selector(yesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    _yesButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _yesButton.layer.borderWidth = 2;
    _yesButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[_yesButton titleLabel] setFont:buttonFont];
    [_yesButton setTitle:@"Select a Class to Drop" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:_yesButton];
    
    _noButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset + 5 -15, textViewWidth, cancelHeight)];
    [_noButton addTarget:self action:@selector(noButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    _noButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _noButton.layer.borderWidth = 2;
    _noButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[_noButton titleLabel] setFont:buttonFont];
    [_noButton setTitle:@"Cancel" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:_noButton];
    
    
    _realNoButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset + 5 -15+ 5 +.0*cancelHeight, textViewWidth, cancelHeight)];
    [_realNoButton addTarget:self action:@selector(realNoButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    _realNoButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _realNoButton.layer.borderWidth = 2;
    _realNoButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[_realNoButton titleLabel] setFont:buttonFont];
    [_realNoButton setTitle:@"No" forState: UIControlStateNormal];
    
  
    
    
    _realYesButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset + 5 -15 - 1*cancelHeight, textViewWidth, cancelHeight)];
    [_realYesButton addTarget:self action:@selector(realYesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    _realYesButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _realYesButton.layer.borderWidth = 2;
    _realYesButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[_realYesButton titleLabel] setFont:buttonFont];
    [_realYesButton setTitle:@"Yes" forState: UIControlStateNormal];
    

    
    [_buttonPane addSubview:_realYesButton];
     [_buttonPane addSubview:_realNoButton];
     [_buttonPane addSubview:_finalView];
    
    _realYesButton.alpha = 0;
    _realNoButton.alpha=0;
    _finalView.alpha=0;
    
    _realYesButton.userInteractionEnabled =NO;
    _realNoButton.userInteractionEnabled =NO;
    _finalView.userInteractionEnabled =NO;
    
   
    
    Course * tempCourse;
    Department * tempDepartment;
    NSMutableArray * temp =  [[ NSMutableArray alloc] init];
    int numClasses =0;
    [temp addObjectsFromArray:[_currentCart getCartArray]];
    for (int i=0; i<[temp count]; i++) {
        tempCourse = temp[i];
        if([_currentCart isRegistered:tempCourse]){
            CustumUI * tempButton = [[CustumUI alloc] initWithFrame:CGRectMake(offset, labelHeight+3*offset-15+cancelHeight*(numClasses+.5), textViewWidth, cancelHeight)];
            [tempButton addTarget:self action:@selector(courseDropWasPressed:) forControlEvents:UIControlEventTouchUpInside];
            [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            tempButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            tempButton.layer.borderWidth = 1;
            tempDepartment = tempCourse.department;
            tempButton.layer.backgroundColor = [ tempDepartment.color CGColor];
            [[tempButton titleLabel] setFont:buttonFont];
            tempButton.finally = tempCourse;
            NSString *abbrev = tempCourse.department.abbrev;
            NSString *abbrevNum = [abbrev stringByAppendingString:tempCourse.number];
             tempButton.tag = abbrevNum;
            [tempButton setTitle:abbrevNum forState: UIControlStateNormal];
            [_buttons addObject:tempButton];
            numClasses++;

        }

    }
    
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

-(void)courseDropWasPressed:(CustumUI *) sender{
    
    UIButton * tempButton;
    for (int i=0; i<[_buttons count]; i++) {
        
        tempButton = _buttons[i];
        
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        
        tempButton.alpha = 0;
        
        [UIView commitAnimations];

        
         tempButton.userInteractionEnabled = NO;
        
    }
    
//    [_buttonPane addSubview:_realYesButton];
//    [_buttonPane addSubview:_realNoButton];
//    [_buttonPane addSubview:_finalView];
    
    _realYesButton.userInteractionEnabled =YES;
    _realNoButton.userInteractionEnabled =YES;
    _finalView.userInteractionEnabled =YES;
    
    NSString *abbrev = @"\n\nDo you really want to drop\n";
    NSString *abbrevNum = [abbrev stringByAppendingString:sender.currentTitle];
    
    NSString *abbrevNum2 = [abbrevNum stringByAppendingString:@"?"];
    

    _finalView.text = abbrevNum2;
    _courseToDrop = sender.finally;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _noButton.alpha = 0;
    
    _realNoButton.alpha =1;
    _realYesButton.alpha = 1;
    _finalView.alpha = 1;
    [UIView commitAnimations];
    _noButton.userInteractionEnabled = NO;
    
    
    
    
}

-(void)yesButtonWasPressed{
    _cannotDrop.text = @"Select A Class to Drop";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    _bookList.alpha = 0;
    _yesButton.alpha = 0;
    _cannotDrop.alpha =0 ;
    
    [UIView commitAnimations];
    _yesButton.userInteractionEnabled = NO;
    
    UIButton * tempButton;
    
    
    for (int i=0; i<[_buttons count]; i++) {
        
        
        tempButton = _buttons[i];
        [_buttonPane addSubview:tempButton];
        tempButton.alpha = 0;
        
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _cannotDrop.alpha =1 ;
    
    for (int i=0; i<[_buttons count]; i++) {
        
        
        tempButton = _buttons[i];
        [_buttonPane addSubview:tempButton];
        tempButton.alpha = 1;
        
    }
    


    
    
    
    
    
    [UIView commitAnimations];
    
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

-(void)realYesButtonWasPressed{
    

    [_currentCart unregisterCourse:_courseToDrop];
    [_currentCart registerCourse:_courseInfo];
    
    
    
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.view.superview.subviews) {
        subView.userInteractionEnabled = YES;
    }
    [self.view removeFromSuperview];
    [_courseView registerRoll];
    

}

-(void)realNoButtonWasPressed{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _realNoButton.alpha = 0;
      _realYesButton.alpha = 0;
    _finalView.alpha =0;
    [UIView commitAnimations];
    
    
    _realNoButton.userInteractionEnabled = NO;
    _realYesButton.userInteractionEnabled = NO;
    _finalView.userInteractionEnabled = NO;
    
    
    UIButton * tempButton;
    for (int i=0; i<[_buttons count]; i++) {
        
        tempButton = _buttons[i];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        
        tempButton.alpha = 1;
        
        [UIView commitAnimations];
        
        
        tempButton.userInteractionEnabled = YES;
        
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    _noButton.alpha = 1;
    
    [UIView commitAnimations];
    _noButton.userInteractionEnabled = YES;
    
}


@end
