//
//  Course.h
//  CourseShopper
//
//  Created by Katharine Patterson on 11/25/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * prof;
<<<<<<< HEAD
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSString * title;
=======
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * totalSeats;
@property (nonatomic, retain) NSString * availableSeats;
>>>>>>> dfade6419d3c1cc911a23a494cbdd67bb60fa2a9
@property (nonatomic, retain) Department *department;

@end
