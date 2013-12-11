//
//  TWTMenuViewController.m
//  TWTSideMenuViewController-Sample
//
//  Created by Josh Johnson on 8/14/13.
//  Copyright (c) 2013 Two Toasters. All rights reserved.
//

#import "CalendarMenuViewController.h"
#import "CalendarViewController.h"
#import "TWTSideMenuViewController.h"
#import "Cart.h"

@interface CalendarMenuViewController (){
    UITextField *newTitleField;
}

@end

@implementation CalendarMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self loadData];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightg.png"]];
//    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    
    //Set up a tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, 230, 600)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    //Set delegate and delegate of tableview to self
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    self.tableView.userInteractionEnabled = YES;    
    
    
    //Set up menu title
    UILabel *cartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 250, 50)];
    [cartsLabel setText:@"CARTS"];
    UIFont *titleFont = [UIFont fontWithName:@"Helvetica Light" size:24];
    [cartsLabel setFont:titleFont];
    [cartsLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:cartsLabel];
    
    
}

- (void)changeButtonPressed
{
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[CalendarViewController new]];
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (void)closeButtonPressed
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source
//Table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cart_title_array.count;//this returns the number of departments in department array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    //Set basic cell properties
    cell.backgroundColor = [UIColor clearColor];
    
    //No background change on cell selection
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Set up and populate label for cart title
    NSString *cartTitle = self.cart_title_array[indexPath.row];
    
    //    UIButton *cartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 60)];
    //    [cartButton setBackgroundColor:[UIColor greenColor]];
    //    [cartButton addTarget:self action:@selector(cartButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];
    if ([cartTitle isEqualToString:@"%ADD+CART%"]) {
        UIImage *addButtonImage = [UIImage imageNamed:@"add_button.png"];
        UIButton *addCartButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, addButtonImage.size.width, addButtonImage.size.height)];
//        [addCartButton setBackgroundColor:[UIColor greenColor]];
        [addCartButton setImage:[UIImage imageNamed:@"add_button.png"] forState:UIControlStateNormal];
        [addCartButton addTarget:self action:@selector(addCartButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:addCartButton];
    }
    else if ([cartTitle isEqualToString:@"%NEW+TITLE%"]) {
        newTitleField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width-20, 40)];
        [newTitleField setBackgroundColor:[UIColor clearColor]];
        [newTitleField setHidden:NO];
        [newTitleField setDelegate:self];
        [newTitleField becomeFirstResponder];
        [newTitleField setPlaceholder:@"New Cart Title"];
        [newTitleField setTextColor:[UIColor grayColor]];
        UIFont *smallFont = [UIFont fontWithName:@"Helvetica Light" size:16];
        [newTitleField setFont:smallFont];
        [cell addSubview:newTitleField];
    }
    else{
        UILabel *cartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 210, 40)];
        [cartLabel setBackgroundColor:[UIColor clearColor]];
        UIFont *smallFont = [UIFont fontWithName:@"Helvetica Light" size:16];
        [cartLabel setFont:smallFont];
        [cartLabel setTextColor:[UIColor grayColor]];
        cartLabel.text = cartTitle;
        [cell addSubview: cartLabel];
    }
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Did select row at index path");
    CalendarViewController *calendar = [[CalendarViewController alloc] init];
    //set Cart
    calendar.cart = self.appDelegate.cartArray[indexPath.row];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:calendar];
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)loadData{
    self.cart_title_array = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.appDelegate.cartArray.count; i++) {
        Cart *cart = self.appDelegate.cartArray[0];
        NSString *title = cart.title;
        [self.cart_title_array addObject:title];
    }
    [self.cart_title_array addObject:@"%ADD+CART%"];
}

-(void)addCartButtonWasTapped:(UIButton *)sender{
//    [self.cart_title_array removeObjectAtIndex:self.cart_title_array.count-1];
    NSLog(@"Yeha");
    [self.cart_title_array removeObject:@"%ADD+CART%"];
    [self.cart_title_array addObject:@"%NEW+TITLE%"];
    [self.tableView reloadData];
}

-(void)addNewCart{
    NSLog(@"Add new cart");
    //Cosmetic cart title array
    [self.cart_title_array removeObject:@"%NEW+TITLE%"];
    [self.cart_title_array addObject:newTitleField.text];
    [self.cart_title_array addObject:@"%ADD+CART%"];
    
    
    //Under the hood add a cart to appdelegate array
    Cart *cart = [[Cart alloc] init];
    NSString *cartTitle = newTitleField.text;
    [cart setTitle:cartTitle];
    [self.appDelegate.cartArray addObject:cart];
    
    //Update menu table
    [newTitleField setHidden:YES];
    [newTitleField resignFirstResponder];
    [self.tableView reloadData];
}


//Text field delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addNewCart];
    [newTitleField resignFirstResponder];
    return YES;
}

@end

