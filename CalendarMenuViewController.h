//
//  CalendarMenuViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/21/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property UIImageView *backgroundImageView;
@property UITableView *tableView;

@property NSMutableArray *cartArray;

-(void)loadData;

@end
