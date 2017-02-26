//
//  Person.m
//  LoadDemo
//
//  Created by 杨晴贺 on 26/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "Person.h"

@implementation Person

+(void)load{
    NSLog(@"Person load") ;
}

+ (void)initialize{
    NSLog(@"Person initialize") ;
}

@end
