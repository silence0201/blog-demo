//
//  Student.m
//  LoadDemo
//
//  Created by 杨晴贺 on 26/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "Student.h"

@implementation Student

+(void)load{
    // [super load] ;
    NSLog(@"Student load") ;
}

+ (void)initialize{
    NSLog(@"Student initialize") ;
}

@end
