//
//  DepartmentTableViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "CourseTableViewController.h"
//for database use
#import "AppDelegate.h"
#import "Department.h"

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
    self.dict = [[NSMutableDictionary alloc] init];
    
    [self loadData];//This populates the department array
    
    //More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.fetchedDeptsArray = [appDelegate getAllDepartments];
    //[appDelegate getClassList];
    [self.tableView reloadData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"we are back loading");
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator=NO;
    
    //More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.fetchedDeptsArray = [appDelegate getAllDepartments];
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
    return [self.fetchedDeptsArray count];
    //return self.departmentArray.count;//this returns the number of departments in department array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //We can uncomment and use this if we want to set up a class and nib for how we want to display the cell
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
//    staticNSString *CellIdentifier = @"PhoneBookCellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    Department * record = [self.fetchedDeptsArray objectAtIndex:indexPath.row];
    //Department * record = [self.classListTest objectAtIndex:indexPath.row];

    
    // Configure the cell...
    NSString *departmentTitle = record.name;
    NSString *departmentAbbrev = record.abbrev;
    UILabel *departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 210, 40)];
    UIFont *departmentFont = [UIFont fontWithName:@"Helvetica Light" size:20];
    departmentLabel.font = departmentFont;
    departmentLabel.text = departmentTitle;
    UILabel *departmentAbbrevLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 95, 40)];
    UIFont *abbrevFont = [UIFont fontWithName:@"Helvetica Light" size:36];
    departmentAbbrevLabel.font = abbrevFont;
    departmentAbbrevLabel.text = departmentAbbrev;
    departmentAbbrevLabel.textColor = [UIColor colorWithRed:0.5 green:0 blue:1 alpha:1];//self.colorArray[indexPath.row];

    
    
    [cell addSubview: departmentLabel];
    [cell addSubview: departmentAbbrevLabel];
    
    NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    NSString *depKey = [index stringByAppendingString: @"dep"];
    NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
    NSString *depAbbrevCode = [index stringByAppendingString: @"depAbbrevCode"];

    [self.dict setObject:departmentLabel.text forKey:depKey];
    [self.dict setObject:departmentAbbrevLabel.textColor forKey:depAbbrevKey];
    [self.dict setObject:departmentAbbrev forKey:depAbbrevCode];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //First get the cell from the table based on the click event/indexpath
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //Then get the department title from the text on the cell's label
    
    NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    NSString *depKey = [index stringByAppendingString: @"dep"];
    NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
    NSString *depAbbrevCode = [index stringByAppendingString: @"depAbbrevCode"];
    
    NSString *department = [self.dict objectForKey:depKey];
    UIColor *departmentColor = [self.dict objectForKey:depAbbrevKey];
    NSString *abbr = [self.dict objectForKey:depAbbrevCode];
    
    //Then instantiate the courses table and set the title to the correct department
    //This is also potentially a nice place where we will eventually query for the courses for the selected department to then display in the next view.. or we'll at least pass the department to then query in the next view
    CourseTableViewController *courseTable = [[CourseTableViewController alloc] init];
    courseTable.navigationItem.title = department;
    courseTable.departmentColor = departmentColor;
    NSLog(@"setting the abrrev of the page to %@",abbr);
    courseTable.abbrev = abbr;

    [self.navigationController pushViewController:courseTable animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
}

//Put the non-delegate methods below

-(void)loadData{
    //This is just to show y'all an example
    self.departmentArray = [NSMutableArray arrayWithObjects:@"Africana Studies", @"Compuer Science", @"Fradin Studies", nil];
    self.departmentAbbrevArray = [NSMutableArray arrayWithObjects:@"AFRI", @"CSCI", @"FRST", nil];
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

-(void)testingDatabase{
    
    
//    NSLog(@"jjjjjjjjjjjjjjjjjjjjj");
//    int value = [_counter intValue];
//    _counter = [NSNumber numberWithInt:value + 1];
//    // Add Entry to PhoneBook Data base and reset all fields
//    NSString *strFromInt = [_counter stringValue];
//    
//    NSString * name = [NSString stringWithFormat:@"%s%@", "Kappi: ", strFromInt];
//    //  1
//    Department * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Department"
//                                                      inManagedObjectContext:self.managedObjectContext];
//    //
//    newEntry.name = name;
//    newEntry.abbrev =@"KAPP";
//
//    //  3
//    NSError *error;
//    if (![self.managedObjectContext save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    //  4
 
}




@end
