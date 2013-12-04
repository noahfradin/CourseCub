//
//  CourseTableViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseViewController.h"
#import "AppDelegate.h"
#import "Department.h"
#import "Course.h"

@interface CourseTableViewController ()

@end

@implementation CourseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //Nav bar stuff
    //In future we'll supply our own images but I wanted to get rid of back text for now (hate it with text).. this is same as departments view
    self.navigationController.navigationBar.topItem.title = @"";
    
    [self loadData];//this calls our own method to populate array we set as a data source
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator=NO;
    
    
    //More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSArray *temp = [appDelegate getAllClassesOfDept:self.abbrev];
    //self.fetchedCourseArray = [appDelegate getAllClassesOfDept:self.abbrev];


    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number"
                                                                     ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    self.fetchedCourseArray = [temp sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"I have fetched this: %@", self.fetchedCourseArray);
    
    //[appDelegate getClassList];
    [self.tableView reloadData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.fetchedCourseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // Configure the cell...
    
    
    //I feel like courseArray should actually have the number and time contained within it like courseArray.number
   // NSString *courseTitle = self.courseArray[indexPath.row];
    
    
    Course * course = [self.fetchedCourseArray objectAtIndex:indexPath.row];
    NSString *courseTitle = course.title;
    NSString *courseNumber = course.number;
    NSString *courseTime = @"jhkjh";
    UILabel *courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 210, 40)];
    UILabel *courseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 210, 40)];
    UIFont *courseFont = [UIFont fontWithName:@"Helvetica Light" size:14];
    courseLabel.font = courseFont;
    courseLabel.text = courseTitle;
    courseTimeLabel.font = courseFont;
    courseTimeLabel.text = courseTime;
    UILabel *courseNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 95, 40)];
    UIFont *numberFont = [UIFont fontWithName:@"Helvetica Light" size:36];
    courseNumberLabel.font = numberFont;
    courseNumberLabel.text = courseNumber;
    courseNumberLabel.textColor = _departmentColor;
    
    [cell addSubview: courseLabel];
    [cell addSubview: courseTimeLabel];
    [cell addSubview: courseNumberLabel];

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //First get the cell from the table based on the click event/indexpath
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //Then get the department title from the text on the cell's label
    NSString *courseTitle = cell.textLabel.text;
    //Then instantiate the course detail view and set the title to the correct course
    //Anything else we need to pass can go here as well
    CourseViewController *courseView = [[CourseViewController alloc] init];
    courseView.navigationItem.title = courseTitle;
    
    [self.navigationController pushViewController:courseView animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
}



//Non-delegate methods below

-(void)loadData{
    
    //This is just an example for y'all
    self.courseArray = [NSMutableArray arrayWithObjects:@"Course1", @"Course2", @"Course3", nil];
    self.courseNumberArray = [NSMutableArray arrayWithObjects:@"0120", @"0222", @"5888", nil];
    
    //In future this is where we'll populate array from nodejs api and the query will pull in utitlizing the department as a parameter to populate the array
    //can either access ns array built intially and only the parts I want or load all into core data and make a request
}


@end
