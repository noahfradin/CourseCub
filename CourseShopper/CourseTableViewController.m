//
//  CourseTableViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseViewController.h"

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
    return self.courseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // Configure the cell...
    
    NSString *courseTitle = self.courseArray[indexPath.row];
    
    cell.textLabel.text = courseTitle;
    
    
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
    courseView.navTitle = courseTitle;
    courseView.navigationItem.title = courseTitle;
    
    [self.navigationController pushViewController:courseView animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
}



//Non-delegate methods below

-(void)loadData{
    
    //This is just an example for y'all
    self.courseArray = [NSMutableArray arrayWithObjects:@"Course1", @"Course2", @"Course3", nil];
    
    //In future this is where we'll populate array from nodejs api and the query will pull in utitlizing the department as a parameter to populate the array
}


@end
