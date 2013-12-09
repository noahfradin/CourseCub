//
//  AppDelegate.h
//  CourseShopper
//
//  Created by Noah Fradin on 9/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "Course.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@private
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;
@property (nonatomic, retain) NSArray *colorArray;

@property (nonatomic, retain) NSMutableArray *adCartArray;

-(NSArray*)getAllDepartments;
-(void)addClassesToCD;
-(NSArray*)getAllClassesOfDept:(NSString *)dept;
-(Department *)getDeptByAbbrev:(NSString *)abbreviation;
-(NSArray *)getData:(NSString *) x;
-(void)addDepartmentsToCD;
- (NSArray *)getCourseBySearch:(NSString *)searchText;


@end
