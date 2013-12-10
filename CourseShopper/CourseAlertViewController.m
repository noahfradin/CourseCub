//
//  CourseAlertViewController.m
//  CourseShopper
//
//  Created by Alexander Meade on 11/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CourseAlertViewController.h"

#define buttonPaneHeight self.view.frame.size.height*46/64
#define buttonPaneWidth self.view.frame.size.width*18/20
#define labelHeight buttonPaneHeight/10
#define offset buttonPaneHeight/30
#define textViewWidth buttonPaneWidth- 2*offset
#define textViewHeight buttonPaneHeight - 4*offset - 2*labelHeight
#define cancelHeight labelHeight

@interface CourseAlertViewController ()

@end

@implementation CourseAlertViewController

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
    
     UIFont *buttonFont = [UIFont fontWithName:@"Helvetica Light" size:24.0];
    
    
    UILabel *bookListLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonPaneWidth, labelHeight)];
    bookListLabel.text = @"Book List";
    UIColor *timeLabelFontColor = [UIColor whiteColor];
    bookListLabel.textAlignment = UITextAlignmentCenter;
    bookListLabel.textColor = timeLabelFontColor;
    bookListLabel.font = buttonFont;
    [_buttonPane addSubview: bookListLabel];
    
    
     UIFont *buttonFont2 = [UIFont fontWithName:@"Helvetica Light" size:20.0];
    
    UITextView *bookList = [[UITextView alloc] initWithFrame:CGRectMake(offset, labelHeight+offset*2, textViewWidth, textViewHeight)];
    bookList.layer.borderColor = [[UIColor whiteColor] CGColor];
    bookList.layer.backgroundColor = [[UIColor grayColor] CGColor];
    bookList.font = buttonFont2;
    bookList.layer.borderWidth = 2;
    bookList.alwaysBounceVertical = YES;
    bookList.editable = NO;
    bookList.textColor = timeLabelFontColor;
    bookList.textAlignment = UITextAlignmentCenter;
    
    
    bookList.text = @"\n\n\nSo far as we know\nthis course doesn't HAVE\n\"books\"";
    

    
    
    [_buttonPane addSubview:bookList];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(offset, labelHeight+textViewHeight+3*offset, textViewWidth, cancelHeight)];
    [cancel addTarget:self action:@selector(cancelButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.borderColor = [[UIColor whiteColor] CGColor];
    cancel.layer.borderWidth = 2;
    cancel.layer.backgroundColor = [[UIColor grayColor] CGColor];
    [[cancel titleLabel] setFont:buttonFont];
    [cancel setTitle:@"Cancel" forState: UIControlStateNormal];
    
    [_buttonPane addSubview:cancel];
    

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

-(void)cancelButtonWasPressed{
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.view.superview.subviews) {
        subView.userInteractionEnabled = YES;
    }
    [self.view removeFromSuperview];
   
 
}




@end
