//
//  DepartmentTableViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "CourseTableViewController.h"

@interface DepartmentTableViewController ()

@end

@implementation DepartmentTableViewController

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
    //In future we'll supply own images but I wanted to get rid of back text for now (hate it with text)
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.title = @"Departments";

    
    [self loadData];//This populates the department array
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.dict = [[NSMutableDictionary alloc] init];
    self.alphabet = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",nil];

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
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    //The basic idea here would be to return the number of items based on the letter of the alphabet the section number referred to
     return [self.alphabetCount[section] integerValue];//this returns the number of departments in department array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //We can uncomment and use this if we want to set up a class and nib for how we want to display the cell
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // Configure the cell...
    
    NSString *departmentTitle = self.departmentArray[indexPath.row];
    NSString *departmentAbbrev = self.departmentAbbrevArray[indexPath.row];
    UILabel *departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 210, 40)];
    UIFont *departmentFont = [UIFont fontWithName:@"Helvetica Light" size:20];
    departmentLabel.font = departmentFont;
    departmentLabel.text = departmentTitle;
    UILabel *departmentAbbrevLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 95, 40)];
    UIFont *abbrevFont = [UIFont fontWithName:@"Helvetica Light" size:36];
    departmentAbbrevLabel.font = abbrevFont;
    departmentAbbrevLabel.text = departmentAbbrev;
    departmentAbbrevLabel.textColor = self.colorArray[indexPath.row];

    
    
    [cell addSubview: departmentLabel];
    [cell addSubview: departmentAbbrevLabel];
    
    NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    NSString *depKey = [index stringByAppendingString: @"dep"];
    NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];

    [self.dict setObject:departmentLabel.text forKey:depKey];
    [self.dict setObject:departmentAbbrevLabel.textColor forKey:depAbbrevKey];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //First get the cell from the table based on the click event/indexpath
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //Then get the department title from the text on the cell's label
    
    NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    NSString *depKey = [index stringByAppendingString: @"dep"];
    NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
    
    NSString *department = [self.dict objectForKey:depKey];
    UIColor *departmentColor = [self.dict objectForKey:depAbbrevKey];
    
    //Then instantiate the courses table and set the title to the correct department
    //This is also potentially a nice place where we will eventually query for the courses for the selected department to then display in the next view.. or we'll at least pass the department to then query in the next view
    CourseTableViewController *courseTable = [[CourseTableViewController alloc] init];
    courseTable.navigationItem.title = department;
    courseTable.departmentColor = departmentColor;

    [self.navigationController pushViewController:courseTable animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.alphabet;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.alphabet indexOfObject:title];
}

//Put the non-delegate methods below

-(void)loadData{
    //This is just to show y'all an example
    self.departmentArray = [NSMutableArray arrayWithObjects:@"Africana Studies", @"Compuer Science", @"Fradin Studies", nil];
    self.departmentAbbrevArray = [NSMutableArray arrayWithObjects:@"AFRI", @"CSCI", @"FRST", nil];
    
    //Though this code doesnt work because I cannot figure out the syntax yet, were it correct it would simply check the first letters of each item in the departmentAbbrevArray, change the letter to a number corresponding to the section numbers, and then use those numbers to count the number of items in each alphabetical section. UGH.
    for (int i = 0; i <= (sizeof self.departmentAbbrevArray); i++) {
        NSString *firstLetter = [self.departmentAbbrevArray[i] substringFromIndex: 1];
        NSInteger number = [firstLetter characterAtIndex: 0] - 65;
        if (self.alphabetCount[number] == nil) {
            self.alphabetCount[number] = 0;
        }
        else {
            self.alphabetCount[number] += 1;
        }
    }
    
    //75 colors
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithRed:1 green:0 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.25 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.75 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.75 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.5 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.25 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.25 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.5 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.75 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.75 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.25 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.25 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.5 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.75 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.75 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.5 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.25 alpha:1],nil];
    
    //In future this is where we'll populate array from nodejs api
}


@end
