//
//  DepartmentTableViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/20/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "CourseTableViewController.h"
#import "CourseViewController.h"
//for database use
#import "AppDelegate.h"
#import "Department.h"

@interface DepartmentTableViewController ()

#define SCREEN_WIDTH 320

@end

@implementation DepartmentTableViewController

@synthesize theSearchBar;

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
//More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    //[appDelegate getClassList];

    [self.tableView reloadData];

    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableView.tableHeaderView = self.theSearchBar;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.theSearchBar.frame = CGRectMake(0,MAX(0,scrollView.contentOffset.y),320,44);
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
    
    self.fetchedDeptsArray = (NSMutableArray *)[appDelegate getAllDepartments];
    //[appDelegate getClassList];
//    NSLog(@"in dept table list returned: %@",self.fetchedDeptsArray);
//    NSLog(@"count of dept array: %ul",[self.fetchedDeptsArray count]);
    
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.dict = [[NSMutableDictionary alloc] init];
    self.alphabet = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z" ,nil];
    self.alphabetCount = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) {
        [self.alphabetCount insertObject:[NSNull null] atIndex:i];
    }

//    self.theSearchBar = [[UISearchBar alloc] init];
//    self.theSearchBar.searchBarStyle = UISearchBarStyleDefault;
    
//    self.theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    
//    self.theSearchBar.delegate = self;
//    
//    self.tableView.tableHeaderView = self.theSearchBar;
    self.theSearchBar = [[UISearchBar alloc] init];
    self.theSearchBar.searchBarStyle = UISearchBarStyleDefault;
    self.theSearchBar.delegate = self;
    self.wasSearched = NO;
    
    
    [self loadData];//This populates the department array
    
    //Accessory view stuff
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [accessoryView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5]];
    self.WRIT = [[UIButton alloc] initWithFrame:CGRectMake(70, 5, 80, 30)];
    [self.WRIT setTitle:@"WRIT" forState:UIControlStateNormal];
    [self.WRIT addTarget:self action:@selector(WRITWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.WRIT setBackgroundColor:[UIColor whiteColor]];
    [self.WRIT setTitleColor:[UIColor grayColor] forState: UIControlStateNormal];
    self.toggle = 0;
    
    self.time = [[UIButton alloc] initWithFrame:CGRectMake(160, 5, 80, 30)];
    [self.time setTitle:@"TIME" forState:UIControlStateNormal];
    [self.time addTarget:self action:@selector(timeWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.time setBackgroundColor:[UIColor whiteColor]];
    [self.time setTitleColor:[UIColor grayColor] forState: UIControlStateNormal];
    
    UILabel *filters = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
    filters.text = @"Filters:";
    filters.textColor = [UIColor whiteColor];
    UIFont *filtersFont = [UIFont fontWithName:@"Helvetica Light" size:18];
    filters.font = filtersFont;
    
    self.theSearchBar.inputAccessoryView = accessoryView;
    [accessoryView addSubview:self.WRIT];
    [accessoryView addSubview:filters];
    [accessoryView addSubview:self.time];
    

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
    //return self.departmentArray.count;//this returns the number of departments in department array
    
    //The basic idea here would be to return the number of items based on the letter of the alphabet the section number referred to
    id numberOfRows = [self.alphabetCount objectAtIndex:section];
    if (numberOfRows == [NSNull null]) {
        return 0;
    }
    else {
        return [numberOfRows integerValue];//this returns the number of departments in department array
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //We can uncomment and use this if we want to set up a class and nib for how we want to display the cell
    //    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
//    staticNSString *CellIdentifier = @"PhoneBookCellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"called");
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];


    
//<<<<<<< HEAD
    // Configure the cell...

    if ([self.fetchedDeptsArray count] == 0) {
        return cell;
    }

    int section = indexPath.section;
    int counter = 0;
    int scounter = 0;
    if (section != 0) {
        while (section > scounter) {
            if (self.alphabetCount[scounter] != [NSNull null]) {
                int numberInSection = [self.alphabetCount[scounter] intValue];
                counter += numberInSection;
                scounter++;
                if (section == scounter) {
                    break;
                }
            }
            else {
                scounter++;
            }
        }
    }
    if (self.wasSearched) {
        Course * course = [self.fetchedDeptsArray objectAtIndex:indexPath.row + counter];
        NSString *courseTitle = course.title;
        NSString *courseNumber = course.number;
        NSString *courseTime = course.time;
        
        UILabel *courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 210, 40)];
        UILabel *courseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 150, 40)];
        UIFont *courseFont = [UIFont fontWithName:@"Helvetica Light" size:14];
        courseLabel.font = courseFont;
        courseLabel.text = courseTitle;
        courseTimeLabel.font = courseFont;
        courseTimeLabel.text = courseTime;
        
        //Actually department (sorry)
        UILabel *courseNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 95, 40)];
        UIFont *numberFont = [UIFont fontWithName:@"Helvetica Light" size:31];
        courseNumberLabel.font = numberFont;
        courseNumberLabel.text = course.department.abbrev;
        
        //Actually course number (sorry)
        UILabel *deptLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 20, 60, 40)];
        deptLabel.font = courseFont;
        deptLabel.text = courseNumber;
        
        if ([self array:self.cart.getCartArray contains:course]) {

            courseNumberLabel.textColor = [UIColor whiteColor];
            courseLabel.textColor = [UIColor whiteColor];
            courseTimeLabel.textColor = [UIColor whiteColor];
            deptLabel.textColor = [UIColor whiteColor];
            
            cell.backgroundColor = course.department.color;
        }
        else {
            courseNumberLabel.textColor = course.department.color;
        }
        
        [cell addSubview: courseLabel];
        [cell addSubview: courseTimeLabel];
        [cell addSubview: courseNumberLabel];
        [cell addSubview: deptLabel];
        
        NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
        NSString *courseKey = [index stringByAppendingString: @"course"];
        
        [self.dict setObject:course forKey:courseKey];
#warning yay
    }
    else {
        Department * record = [self.fetchedDeptsArray objectAtIndex:indexPath.row + counter];
        NSString *departmentTitle = record.name;
        NSString *departmentAbbrev = record.abbrev;


        UILabel *departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 210, 40)];
        UIFont *departmentFont = [UIFont fontWithName:@"Helvetica Light" size:20];
        departmentLabel.font = departmentFont;
        departmentLabel.text = departmentTitle;
    
        UILabel *departmentAbbrevLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 95, 40)];
        UIFont *abbrevFont = [UIFont fontWithName:@"Helvetica Light" size:31];
        departmentAbbrevLabel.font = abbrevFont;
        departmentAbbrevLabel.text = departmentAbbrev;
        departmentAbbrevLabel.textColor = record.color;

    
        [cell addSubview: departmentLabel];
        [cell addSubview: departmentAbbrevLabel];
    
    
        NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
        NSString *depKey = [index stringByAppendingString: @"dep"];
        NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
    
        NSString *depAbbrevCode = [index stringByAppendingString: @"depAbbrevCode"];

        [self.dict setObject:departmentLabel.text forKey:depKey];
        [self.dict setObject:departmentAbbrevLabel.textColor forKey:depAbbrevKey];
        [self.dict setObject:departmentAbbrev forKey:depAbbrevCode];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //First get the cell from the table based on the click event/indexpath
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.wasSearched) {
        NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
        NSString *courseKey = [index stringByAppendingString: @"course"];
        
        Course *course = [self.dict objectForKey:courseKey];
        CourseViewController *courseController = [[CourseViewController alloc] init];
        courseController.courseTitle = course.title;
        courseController.departmentColor = course.department.color;
        NSString *abbrev = course.department.abbrev;
        NSString *abbrevNum = [abbrev stringByAppendingString:course.number];
        courseController.navigationItem.title = abbrevNum;
        courseController.abbrevNum = abbrevNum;
        [self.navigationController pushViewController:courseController animated:YES];
        
    }
    else {
        NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
        NSString *depKey = [index stringByAppendingString: @"dep"];
        NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
        NSString *depAbbrevCode = [index stringByAppendingString: @"depAbbrevCode"];
    
        NSString *department = [self.dict objectForKey:depKey];
        UIColor *departmentColor = [self.dict objectForKey:depAbbrevKey];
        NSString *abbr = [self.dict objectForKey:depAbbrevCode];
        NSLog(@"the course value is: %@", department);
        //Then instantiate the courses table and set the title to the correct department
        //This is also potentially a nice place where we will eventually query for the courses for the selected department to then display in the next view.. or we'll at least pass the department to then query in the next view
        CourseTableViewController *courseTable = [[CourseTableViewController alloc] init];
        courseTable.navigationItem.title = department;
        courseTable.department = department;
        courseTable.departmentColor = departmentColor;
    
    
        NSLog(@"setting the abrrev of the page to %@",abbr);
        courseTable.abbrev = abbr;

        [self.navigationController pushViewController:courseTable animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.alphabet;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.alphabet indexOfObject:title];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    self.wasSearched = NO;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.fetchedDeptsArray = (NSMutableArray *)[appDelegate getAllDepartments];
    self.alphabetCount = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) {
        [self.alphabetCount insertObject:[NSNull null] atIndex:i];
    }
    
    [self resetSections];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
//    NSArray *resultsAbbrev = [self searchThroughArray:(self.departmentAbbrevArray) withString: searchBar.text];
//    NSArray *resultsDept = [self searchThroughArray:(self.departmentArray) withString: searchBar.text];
	
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
	
    self.wasSearched = YES;
    self.fetchedDeptsArray = [[NSMutableArray alloc] init];

    NSArray *results = [self searchWithString:searchBar.text];
    [self.fetchedDeptsArray addObjectsFromArray:results];
    
    self.alphabetCount = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) {
        [self.alphabetCount insertObject:[NSNull null] atIndex:i];
    }
    
    [self resetSections];
    [self.tableView reloadData];
}

//Put the non-delegate methods below

-(NSArray *)searchWithString:(NSString *)stringToSearch {
  
    //More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
//    return self.fetchedDeptsArray;
    return [appDelegate getCourseBySearch:stringToSearch];

}

//Check the first letters of each item in the departmentAbbrevArray, change the letter to a number corresponding to the section numbers, and then use those numbers to count the number of items in each alphabetical section. UGH.
-(void) resetSections{
    for (int i = 0; i < [self.fetchedDeptsArray count]; i++) {
        if (self.wasSearched) {
            self.firstLetter = [[[(Course *)[self.fetchedDeptsArray objectAtIndex:i] department] abbrev] substringToIndex: 1];
        }
        else {
            self.firstLetter = [[[self.fetchedDeptsArray objectAtIndex:i] abbrev] substringToIndex: 1];
        }
        int letter = [self.firstLetter characterAtIndex:0] - 65;
        if ([NSNull null] == [self.alphabetCount objectAtIndex:letter]) {
            NSNumber *one = [NSNumber numberWithInteger:1];
            [self.alphabetCount insertObject:one atIndex:letter];
        }
        else {
            NSNumber *number = [self.alphabetCount objectAtIndex:letter];
            NSInteger numberint = [number integerValue];
            numberint++;
            number = [NSNumber numberWithInteger:numberint];
            self.alphabetCount[letter] = number;
        }
    }
}

-(void)loadData{
    //This is just to show y'all an example
    [self resetSections];
    
    
    //In future this is where we'll populate array from nodejs api
}

-(BOOL)array:(NSMutableArray *)array contains:(Course *)course {
    for (int i = 0; i < [array count]; i++) {
        if (course == array[i]) {
            return YES;
        }
    }
    return NO;
}

-(void)WRITWasPressed {
    if (self.toggle == 0){
        [self.WRIT setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:208.0f/255.0f blue:139.0f/255.0f alpha:1] forState: UIControlStateNormal];
        self.toggle = 1;
    }
    else {
        [self.WRIT setTitleColor:[UIColor grayColor] forState: UIControlStateNormal];
        self.toggle = 0;
    }
}

-(void)timeWasPressed{
    
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

- (void)oneTimeMethodCall{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL dict_is_populated = [defaults boolForKey: @"dict_is_populated"];
    if (!dict_is_populated) {
        //Call method you want to be called once here
        [defaults setObject:self.dict forKey:@"dept_dict"];
        [defaults setBool:YES forKey: @"dict_is_populated"];
    }
}


@end
