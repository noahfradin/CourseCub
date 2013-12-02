//
//  CalendarMenuViewController.m
//  CourseShopper
//
//  Created by Noah Fradin on 11/21/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "CalendarMenuViewController.h"
#import "CalendarViewController.h"
#import "TWTSideMenuViewController.h"

@interface CalendarMenuViewController ()

@end

@implementation CalendarMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightgauss"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    self.view.userInteractionEnabled = NO;
    self.backgroundImageView.userInteractionEnabled = NO;
    
    //Set up a tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, 230, 600)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    //Set delegate and delegate of tableview to self
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.tableView reloadData];
    [self.backgroundImageView addSubview:self.tableView];
    self.tableView.userInteractionEnabled = YES;
    
    //Set up menu title
    UILabel *cartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 250, 50)];
    [cartsLabel setText:@"CARTS"];
    UIFont *titleFont = [UIFont fontWithName:@"Helvetica Light" size:24];
    [cartsLabel setFont:titleFont];
    [cartsLabel setTextColor:[UIColor grayColor]];
    [self.backgroundImageView addSubview:cartsLabel];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    [self loadData];
    return self.cartArray.count;//this returns the number of departments in department array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    //Set basic cell properties
    cell.backgroundColor = [UIColor clearColor];
    
    //Set up and populate label for cart title
    NSString *cartTitle = self.cartArray[indexPath.row];
    UILabel *cartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 210, 40)];
    [cartLabel setBackgroundColor:[UIColor clearColor]];
    UIFont *smallFont = [UIFont fontWithName:@"Helvetica Light" size:16];
    [cartLabel setFont:smallFont];
    [cartLabel setTextColor:[UIColor grayColor]];
    cartLabel.text = cartTitle;
    [cell addSubview: cartLabel];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Did select row at index path");
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[CalendarViewController new]];
    [self.sideMenuViewController setMainViewController:controller animated:NO closeMenu:YES];
}

-(void)loadData{
    //This is just to show y'all an example
    self.cartArray = [NSMutableArray arrayWithObjects:@"Da Best Cart", @"Fradin's Cart", @"Mediocre Cart", nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
