//
//  CCCourseButton.h
//  CourseShopper
//
//  Created by Noah Fradin on 12/10/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CCCourseButton : UIButton

@property Course *course;
@property BOOL conflict;
@property NSMutableArray *conflictArray;

@end
