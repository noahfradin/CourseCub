//
//  DepartmentTableViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentTableViewController : UITableViewController

@property NSMutableArray *departmentArray;
@property NSMutableArray *departmentAbbrevArray;
@property NSMutableArray *colorArray;
@property NSMutableDictionary *dict;
@property NSMutableArray *alphabet;
@property NSMutableArray *alphabetCount;

-(void)loadData;

@end
