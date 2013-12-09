//
//  CourseTableViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTableViewController : UITableViewController

@property NSMutableArray *courseArray;
@property NSMutableArray *courseNumberArray;
@property UIColor *departmentColor;
@property NSString *abbrev;
//database stuff
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSArray* fetchedCourseArray;

@property NSString *department;

-(void)loadData;
-(void) setWasSearched:(BOOL *)wasSearched;

@end
