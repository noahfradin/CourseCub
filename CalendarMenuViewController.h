//
//  CalendarMenuViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/21/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CalendarMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property UIImageView *backgroundImageView;
@property UITableView *tableView;

@property NSMutableArray *cart_title_array;

@property AppDelegate *appDelegate;

-(void)loadData;
-(void)addCartButtonWasTapped:(UIButton *)sender;
-(void)addNewCart;
@end
