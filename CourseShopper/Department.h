//
//  Department.h
//  CourseShopper
//
//  Created by Katharine Patterson on 11/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSNumber * color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * abbrev;
@property (nonatomic, retain) NSSet *courses;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
