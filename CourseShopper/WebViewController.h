//
//  WebViewController.h
//  CourseShopper
//
//  Created by Alexander Meade on 12/3/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseViewController.h"

@interface WebViewController : UIViewController <UIWebViewDelegate> 

@property NSString * currentUrl;
@property CourseViewController * courseView;

@end
