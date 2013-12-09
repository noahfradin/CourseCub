//
//  Cart.m
//  CourseShopper
//
//  Created by Noah Fradin on 12/9/13.
//  Copyright (c) 2013 Noah Fradin. All rights reserved.
//

#import "Cart.h"

@implementation Cart

-(id)init{
    self = [super init];
    if (self) {
        //Initialize data structures
        self.courses_Dict = [[NSMutableDictionary alloc] init];
        self.courses_Array = [[NSMutableArray alloc] init];
    }
    return self;
}

////////////////////
//Cart Manipulation
///////////////////
//Takes course and sets state to registered
-(void)registerCourse:(Course *)course{
    NSLog(@"Register");
    [self.courses_Dict setObject:[NSNumber numberWithInt:0] forKey:course.number];
}

//Takes course and adds it to cart with pending state
-(void)addCourse:(Course *)course{
    NSLog(@"Add");
    [self.courses_Dict setObject:[NSNumber numberWithInt:1] forKey:course.number];
    [self.courses_Array addObject:course];
}

//Takes course and sets state to notify
-(void)notifyCourse:(Course *)course{
    NSLog(@"Notify");
    [self.courses_Dict setObject:[NSNumber numberWithInt:2] forKey:course.number];
}

//Takes course and removes it from cart
-(void)removeCourse:(Course *)course{
    NSLog(@"Remove");
    [self.courses_Dict removeObjectForKey:course.number];//Remove from dictionary
    [self.courses_Array removeObject:course];//Remove from array
}

////////////////////
//Course state info
////////////////////
//Takes course and returns registration status
-(BOOL)isRegistered:(Course *)course{
    int state = [[self.courses_Dict objectForKey:course.number] intValue];
    if (state==0) {
        return YES;
    }
    else{
        return NO;
    }
}

//Takes course and returns in cart status
-(BOOL)isInCart:(Course *)course{
    int state = [[self.courses_Dict objectForKey:course.number] intValue];
    if (state==1) {
        return YES;
    }
    else{
        return NO;
    }
}

//Takes course and returns notification status
-(BOOL)isNotifying:(Course *)course{
    int state = [[self.courses_Dict objectForKey:course.number] intValue];
    if (state==2) {
        return YES;
    }
    else{
        return NO;
    }
}


////////////////////////////
//Get data structure methods
////////////////////////////
//Returns NSMutableDictionary of cart with courses mapped to their state
-(NSMutableDictionary*)getCartDict{
    return self.courses_Dict;
}

//Returns state independent list of courses in the cart
-(NSMutableArray*)getCartArray{
    return self.courses_Array;
}

@end
