//
//  EnumDemo.h
//  enumDemo
//
//  Created by 杨晴贺 on 16/7/18.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnumDemo : NSObject

//NS_ENUM声明出来的大部分是单选
typedef NS_ENUM(NSInteger,SIEnum){
    SIEnumTop  = 1 << 0 ,
    SIEnumBotton = 1 << 1,
    SIEnumLeft = 1 << 2 ,
    SIEnumRight = 1 << 3
};
//NS_OPTIONS声明出来的大部分是多选
typedef NS_OPTIONS(NSInteger, SIOption){
    SIOptionNone = 0 ,
    SIOptionTop = 1 << 0 ,
    SIOptionBotton = 1 << 1 ,
    SIOptionLeft = 1 << 2 ,
    SIOptionRight = 1 << 3
};

@property (nonatomic,strong) NSMutableDictionary *enumDescribeDic ;  //枚举的字典描述
@property (nonatomic,strong) NSMutableDictionary *optionDescribrDic ;  // 选项枚举的字典描述

+ (instancetype)instance ;
- (void)enumDemo ;
- (void)optionDemo ;

@end
