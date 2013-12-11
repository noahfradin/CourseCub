//
//  Cart.h
//  CourseShopper
//
//  Created by Noah Fradin on 12/9/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface Cart : NSObject

@property NSMutableDictionary *courses_Dict;//Dictionary of courses
@property NSMutableArray *courses_Array;//Array of classes in cart

@property NSString *title;

-(void)registerCourse:(Course *)course;
-(void)addCourse:(Course *)course;
-(void)removeCourse:(Course *)course;
-(void)notifyCourse:(Course *)course;
-(void)unregisterCourse:(Course *)course;

-(BOOL)isRegistered:(Course *)course;
-(BOOL)isInCart:(Course *)course;
-(BOOL)isNotifying:(Course *)course;

-(NSMutableDictionary*)getCartDict;
-(NSMutableArray*)getCartArray;


@end
