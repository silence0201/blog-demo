//
//  EnumDemo.m
//  enumDemo
//
//  Created by 杨晴贺 on 16/7/18.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "EnumDemo.h"

@implementation EnumDemo

- (instancetype)init{
    if (self = [super init]) {
        NSMutableDictionary *enumDic =[ @{@(SIEnumTop): @"top",
                                         @(SIEnumBotton):@"botton",
                                         @(SIEnumLeft):@"left",
                                         @(SIEnumRight):@"right"} mutableCopy];
        NSMutableDictionary *optionDic = [ @{@(SIOptionTop): @"top",
                                           @(SIOptionBotton):@"botton",
                                           @(SIOptionLeft):@"left",
                                           @(SIOptionRight):@"right"} mutableCopy] ;
        self.enumDescribeDic = enumDic ;
        self.optionDescribrDic = optionDic ;
    }
    
    return self ;
}

+ (instancetype)instance{
    static EnumDemo *single = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (single == nil) {
            single = [[self alloc]init] ;
        }
    });
    return single ;
}

- (SIEnum)enumTypeForKey:(NSString *)key{
    for (NSNumber *mapKey in self.enumDescribeDic.allKeys) {
        NSString *value = self.enumDescribeDic[mapKey] ;
        if ([value isEqualToString:key]) {
            return mapKey.integerValue ;
        }
    }
    return 0 ;
}

- (SIOption)optionTypeForKey:(NSString *)key{
    for (NSNumber *mapKey in self.optionDescribrDic.allKeys) {
        NSString *value = self.optionDescribrDic[mapKey] ;
        if ([value isEqualToString:key]) {
            return mapKey.integerValue ;
        }
    }
    return 0 ;
}

- (void)enumDemo{
    NSString *chose = @"top" ;
    SIEnum en = [self enumTypeForKey:chose] ;
    NSInteger type = en ;
    NSLog(@"=========") ;
    if (type & SIOptionTop) {
        NSLog(@"向上") ;
    }
    if (type & SIOptionBotton) {
        NSLog(@"向下") ;
    }
    if (type & SIOptionRight) {
        NSLog(@"向右") ;
    }
    if (type & SIOptionLeft) {
        NSLog(@"向左") ;
    }
}

- (void)optionDemo{
    NSString *option1 = @"top" ;
    NSString *option2 = @"right" ;
    SIOption op1 = [self optionTypeForKey:option1] ;
    SIOption op2 = [self optionTypeForKey:option2] ;
    NSLog(@"=========") ;
    NSInteger type = op1 | op2 ;
    
    if (type & SIOptionTop) {
        NSLog(@"向上") ;
    }
    if (type & SIOptionBotton) {
        NSLog(@"向下") ;
    }
    if (type & SIOptionRight) {
        NSLog(@"向右") ;
    }
    if (type & SIOptionLeft) {
        NSLog(@"向左") ;
    }
    
}

@end
