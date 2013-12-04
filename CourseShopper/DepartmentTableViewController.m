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
    
    
    [self loadData];//This populates the department array
    
    //More database stuff
    // get an instance of app delegate
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Make manageObjectContext of the Controller point to AppDelegate’s manageObjectContext object.
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.fetchedDeptsArray = [appDelegate getAllDepartments];
    //[appDelegate getClassList];
    [self resetSections];
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
    
    

    
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.dict = [[NSMutableDictionary alloc] init];
    self.alphabet = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",nil];
    self.alphabetCount = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) {
        [self.alphabetCount insertObject:[NSNull null] atIndex:i];
    }
    self.theSearchBar = [[UISearchBar alloc] init];
    self.theSearchBar.searchBarStyle = UISearchBarStyleDefault;
    [self resetSections];
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
    Department * record = [self.fetchedDeptsArray objectAtIndex:indexPath.row + counter];
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
    departmentAbbrevLabel.textColor = self.colorArray[indexPath.row + counter];

    
    
    [cell addSubview: departmentLabel];
    [cell addSubview: departmentAbbrevLabel];
    
    
    NSString *index = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    NSString *depKey = [index stringByAppendingString: @"dep"];
    NSString *depAbbrevKey = [index stringByAppendingString: @"depAbbrev"];
    
    NSString *depAbbrevCode = [index stringByAppendingString: @"depAbbrevCode"];

    [self.dict setObject:departmentLabel.text forKey:depKey];
    [self.dict setObject:departmentAbbrevLabel.textColor forKey:depAbbrevKey];
    [self.dict setObject:departmentAbbrev forKey:depAbbrevCode];
    
    //this is for finding and deleting specific colors when searching
    [self.dict setObject:departmentAbbrevLabel.textColor forKey:departmentAbbrev];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //First get the cell from the table based on the click event/indexpath
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
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
    courseTable.department = department;
    courseTable.departmentColor = departmentColor;
    
    
    NSLog(@"setting the abrrev of the page to %@",abbr);
    courseTable.abbrev = abbr;

    [self.navigationController pushViewController:courseTable animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//Deselect so the select color view doesn't show up again when the user returns to the view
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.alphabet;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.alphabet indexOfObject:title];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar = theSearchBar;
    [searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar = theSearchBar;
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [self loadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
//    NSArray *resultsAbbrev = [self searchThroughArray:(self.departmentAbbrevArray) withString: searchBar.text];
//    NSArray *resultsDept = [self searchThroughArray:(self.departmentArray) withString: searchBar.text];
	
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
	
//    [self.departmentAbbrevArray removeAllObjects];
//    [self.departmentArray removeAllObjects];
//    [self.colorArray removeAllObjects];
//    [self.alphabetCount removeAllObjects];
//    
//    //NEED TO EITHER FIGURE OUT HOW TO SEARCH BOTH DEPARTMENT AND ABBREVS AT SAME TIME AND SHOW COMBINED RESULTS OR JUST SEARCH BY DEPARTMENT TITLE
//    [self.departmentAbbrevArray addObjectsFromArray:resultsAbbrev];
//    [self.departmentArray addObjectsFromArray:resultsDept];
//    [self resetSections];
    
    
//    //NEED TO ALSO ADD BACK ASSOCIATED DEPARTMENT COLORS
//    for (int i = 0; i < (sizeof self.departmentAbbrevArray); i++) {
//        UIColor *color = [self.dict objectForKey: [self.departmentAbbrevArray objectAtIndex:i]];
//        [self.colorArray addObject:color];
//    }
    
    [self.tableView reloadData];
}

//Put the non-delegate methods below

-(NSArray *)searchThroughArray:(NSMutableArray *)array withString:(NSString *)stringToSearch {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    
    NSArray *results = [array filteredArrayUsingPredicate:predicate];
    return results;
}

//Check the first letters of each item in the departmentAbbrevArray, change the letter to a number corresponding to the section numbers, and then use those numbers to count the number of items in each alphabetical section. UGH.
-(void) resetSections{
    for (int i = 0; i < [self.fetchedDeptsArray count] - 1; i++) {
        NSString *firstLetter = [[[self.fetchedDeptsArray objectAtIndex:i] abbrev] substringToIndex: 1];
        int letter = [firstLetter characterAtIndex:0] - 65;
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
    
    //75 colors
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithRed:1 green:0 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.08 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.16 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.25 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.33 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.41 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.58 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.66 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:0.75 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.83 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:.91 blue:0 alpha:1],
                       [UIColor colorWithRed:1 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.92 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:84 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.75 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.67 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.59 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.5 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.42 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.34 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0.25 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.17 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:.09 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.08 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.16 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.25 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.33 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.41 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.5 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.58 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:66 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:0.75 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.83 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:.91 alpha:1],
                       [UIColor colorWithRed:0 green:1 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.92 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.84 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.75 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.67 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.59 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.42 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.34 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0.25 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.17 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:.09 blue:1 alpha:1],
                       [UIColor colorWithRed:0 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.08 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.16 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.25 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.33 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.41 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.5 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.58 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.66 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:0.75 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.83 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:.91 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:1 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.92 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.84 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.75 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.67 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.59 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.5 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.42 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.34 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:0.25 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.20 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.15 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.10 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.05 alpha:1],
                       [UIColor colorWithRed:1 green:0 blue:.02 alpha:1],nil];
    
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
