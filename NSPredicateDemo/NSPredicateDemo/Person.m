//
//  Person.m
//  NSPredicateDemo
//
//  Created by 杨晴贺 on 16/7/16.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name andAge:(NSInteger)age{
    if (self =  [super init]) {
        self.age = age ;
        self.name = name ;
    }
    return self ;
}

+ (instancetype)personWithName:(NSString *)name andAge:(NSInteger)age{
    return [[self alloc]initWithName:name andAge:age] ;
}

- (NSString *)description{
    NSString *desc = [NSString stringWithFormat:@"name:%@,age:%ld",self.name,self.age] ;
    return desc ;
}

@end
