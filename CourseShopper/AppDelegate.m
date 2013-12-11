//
//  AppDelegate.m
//  CourseShopper
//
//  Created by Noah Fradin on 9/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Cart.h"


@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    // Override point for customization after application launch.
    
    //#Setting window and frame presets like a boss
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.tintColor = [UIColor redColor];

//    [self oneTimeMethodCall];
    [self loadColours];
    [self addDepartmentsToCD];
    [self addClassesToCD];
    
    //Setting the initial viewcontroller like a boss
#warning once login is set up we need to set conditional for when user is already logged in => calendar view
    LoginViewController *login = [[LoginViewController alloc] init];
    
    self.window.rootViewController = login;

    [self.window makeKeyAndVisible];
    
    
    
    //###########Calendar stuff
    //    self.adCartArray = [NSMutableArray arrayWithObjects:@"Da Best Cart", @"Fradin's Cart", @"Mediocre Cart", nil];
    
    //Set up initial cart
    Cart *cart = [[Cart alloc] init];
    [cart setTitle:@"Da Best Cart"];
    self.cartArray = [[NSMutableArray alloc] init];
    [self.cartArray addObject:cart];
    
//    [[NSUserDefaults standardUserDefaults] setObject:self.cartArray forKey:@"cartArray"];
    //########################
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (persistentStoreCoordinator != nil)
    {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CourseShopper.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSArray*)getAllDepartments
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"abbrev" ascending:YES];
    NSArray *sortedArray=[fetchedRecords sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    // Returning Fetched Records
    return sortedArray;
}

//this should return all classes of a given department (passed in as a string)
-(NSArray*)getAllClassesOfDept:(NSString *)dept
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSString *departmentName = dept;
    NSLog(@"helllooo %@",departmentName);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"department.abbrev like %@", departmentName];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"the resulting array is %@",fetchedRecords);
    // Returning Fetched Records
    return fetchedRecords;
    
}

-(Department*)getDeptByAbbrev:(NSString *)abbreviation
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"abbrev like %@", abbreviation];
    [fetchRequest setPredicate:predicate];
    NSError* error;
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *temp = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if ([temp count]>=1){
        Department *fetchedDept = [temp objectAtIndex:0];
        // Returning Fetched Records
        return fetchedDept;
    }
    else
    {
        return nil;
    }
    
}


-(Course*)getCourseInfo:(NSString *)title
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSLog(@"the title given to me is: %@", title);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"title like %@", title];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return [fetchedRecords objectAtIndex:0];
}

-(NSArray*)getCourseBySearch:(NSString *)searchTerm

{
    
    NSLog(@"getCourse was called");
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",searchTerm];
    
    [fetchRequest setPredicate:predicate];
    NSError* error;
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *temp = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([temp count] == 0) {
        NSLog(@"FUUUuUUUUUCK");
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"department.abbrev" ascending:YES];
    NSArray *sortedArray=[temp sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    return sortedArray;

    
}


//reads from a text file of departmenst, parses the file and returns an nsarray of the deparment names
- (NSArray *)getData:(NSString *)x
{
    NSString *title = x;
    NSString *type = @"txt";
    NSString *fileText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:title ofType:type] encoding:NSMacOSRomanStringEncoding error:nil];
    
    NSArray *dataClient = [fileText componentsSeparatedByString: @"#"]; //to load txt
    return dataClient;
}


-(void)addClassesToCD
{
    NSArray *desc = [self getData: @"desc"];
    NSArray *profs = [self getData: @"profs"];
    NSArray *locs = [self getData: @"locs"];
    NSArray *lats = [self getData: @"lats"];
    NSArray *longs = [self getData: @"longs"];
    
    NSMutableArray *times = [NSMutableArray arrayWithObjects:
                             @"MWF 9-10}",
                             @"MWF 10-11}",
                             @"MWF 11-12}",
                             @"MWF 12-1}",
                             @"MWF 1-2}",
                             @"MWF 2-3}",
                             @"MWF 3-4}",
                             @"MWF 4-5}",
                             @"MWF 5-6}",
                             @"TR 9-10.5}",
                             @"TR 10.5-12}",
                             @"TR 1-2.5}",
                             @"TR 2.5-4}",
                             nil];
    
    NSArray *avSeats = [NSArray arrayWithObjects:
                             @"kapi",
                             @"998",
                             @"940",
                             @"0",
                             @"12",
                             @"30",
                             @"0",
                             @"999",
                             nil];
    
    NSArray *totSeats = [NSArray arrayWithObjects:
                               @"kappi",
                               @"999",
                               @"999",
                               @"30",
                               @"20",
                               @"30",
                               @"12",
                               @"999",
                               nil];
    
    
    NSError* err = nil;
    NSString *classList = [[NSBundle mainBundle] pathForResource:@"class_list" ofType:@"json"];
    

    NSDictionary *classes = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:classList] options:kNilOptions error:&err];


     //add the class as a course, then set up relationship to department
    for(NSString *key in classes)
    {
        NSString *firstWord = [[key componentsSeparatedByString:@" "] objectAtIndex:0];

        
        if ([self getDeptByAbbrev:firstWord]) {
            Course * newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                               inManagedObjectContext:self.managedObjectContext];
            
            newCourse.number = [[key componentsSeparatedByString:@" "] objectAtIndex:1];
            newCourse.title = [classes objectForKey:key];
            
            NSUInteger randomIndexTimes = arc4random() % [times count];
            newCourse.time = [times objectAtIndex:randomIndexTimes];
            
            NSUInteger randomIndexDesc = arc4random() % [desc count];
            newCourse.descr = [desc objectAtIndex:randomIndexDesc];
            
            NSUInteger randomIndexProfs = arc4random() % [profs count];
            newCourse.prof = [profs objectAtIndex:randomIndexProfs];

            NSUInteger randomSeats = ((arc4random() % ([avSeats count]-1))+1);
            newCourse.availableSeats = [avSeats objectAtIndex:randomSeats];
            newCourse.totalSeats = [totSeats objectAtIndex:randomSeats];
            
            
            NSUInteger randomIndexLocs = arc4random() % [locs count];
            NSString *loc = [locs objectAtIndex:randomIndexLocs];
            newCourse.location = loc;
            newCourse.lats = [lats objectAtIndex:randomIndexLocs];
            newCourse.longs = [longs objectAtIndex:randomIndexLocs];
            
            newCourse.department = [self getDeptByAbbrev:firstWord];
        }
    }
}

#pragma addDepartments
-(void)addDepartmentsToCD
{
    NSArray *deps = [self getData: @"titles"];
    NSArray *abbrevs = [self getData: @"abbrevs"];

    for(NSString *abr in abbrevs)
    {
        if (![abr  isEqual: @""] && ![abr isEqualToString:@"AMST"]) {
            NSUInteger i = [abbrevs indexOfObject:abr];
            NSString * dep = [deps objectAtIndex:i];
            Department * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.managedObjectContext];
            newEntry.name = dep;
            newEntry.abbrev = abr;
            newEntry.color = [self.colorArray objectAtIndex:i];
            
            
            NSError *error;
            if ([self getDeptByAbbrev:abr] == nil) {
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
            
        }
      
    }
    

}

//Place this in the appdelegate and call it from didFinishLaunchingWithOptions method
#pragma oneTimeMethodCall
//Checks to see if flag set in NSUserDefaults is set and if not calls desired method and sets the flag.
- (void)oneTimeMethodCall{
    BOOL is_first_time = [[NSUserDefaults standardUserDefaults] boolForKey: @"is_first_time"];
    if (!is_first_time) {
        //Call method you want to be called once here

//        [self addDepartmentsToCD];
//        [self addClassesToCD];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"is_first_time"];
    }
}

-(void)loadColours
{
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
                       [UIColor colorWithRed:.8 green:.8 blue:0 alpha:1],
                       [UIColor colorWithRed:.72 green:.8 blue:0 alpha:1],
                       [UIColor colorWithRed:.64 green:.8 blue:0 alpha:1],
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
                       [UIColor colorWithRed:0 green:1 blue:.66 alpha:1],
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
}

@end
