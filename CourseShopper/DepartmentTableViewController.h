//
//  DepartmentTableViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cart.h"

@interface DepartmentTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    UISearchBar *theSearchBar;
}

@property NSMutableArray *colorArray;
@property NSMutableDictionary *dict;

@property NSNumber *counter;
//testing inserting into table
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSMutableArray* fetchedDeptsArray;
@property (nonatomic,strong)NSArray* classListTest;

@property Cart *cart;

@property NSMutableArray *alphabet;
@property NSMutableArray *alphabetCount;
@property (nonatomic, retain) UISearchBar *theSearchBar;
@property BOOL wasSearched;
@property BOOL pickerActive;
@property BOOL searchActive;
@property NSString *firstLetter;
@property UIButton *WRIT;
@property UIButton *time;
@property int toggle;
@property UIPickerView *pickerView;
@property UIView *whiteBottom;
@property NSMutableArray *hourList;
@property NSMutableArray *hourAbbrevList;
@property UILabel *currentHour;
@property UILabel *timeLabel;

-(void)loadData;
-(BOOL)array:(NSMutableArray *)array contains: (Course *)course;
-(void)WRITWasPressed;
-(void)timeWasPressed;

@end
