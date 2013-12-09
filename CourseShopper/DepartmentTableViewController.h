//
//  DepartmentTableViewController.h
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    UISearchBar *theSearchBar;
}

@property NSMutableArray *colorArray;
@property NSMutableDictionary *dict;

@property NSNumber *counter;
//testing inserting into table
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSMutableArray* fetchedDeptsArray;
@property (nonatomic,strong)NSArray* classListTest;

@property NSMutableArray *alphabet;
@property NSMutableArray *alphabetCount;
@property (nonatomic, retain) UISearchBar *theSearchBar;
@property BOOL wasSearched;
@property NSString *firstLetter;


-(void)loadData;


@end
