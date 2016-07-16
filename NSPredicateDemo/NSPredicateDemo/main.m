//
//  main.m
//  NSPredicateDemo
//
//  Created by 杨晴贺 on 16/7/16.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *persons = [NSArray arrayWithObjects:
                            [Person personWithName:@"小明" andAge:20],
                            [Person personWithName:@"小红" andAge:30],
                            [Person personWithName:@"小强" andAge:40],
                            [Person personWithName:@"小王" andAge:50],
                            [Person personWithName:@"老王" andAge:60],
                            [Person personWithName:@"小钱" andAge:10],
                            [Person personWithName:@"小" andAge:10],
                            [Person personWithName:@"小小和" andAge:15],nil] ;
        //年龄小于30，定义谓词，对此对象中包含了过滤条件
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age<%d",30] ;
        //使用谓词条件过滤数组的元素，过滤之后返回查询的结果
        NSArray *a1 = [persons filteredArrayUsingPredicate:predicate] ;
        //输出
        NSLog(@"%@",a1) ;
        
        //使用并运算
        predicate = [NSPredicate predicateWithFormat:@"name=%@ AND age=%ld",@"小明",20] ;
        //进行删选
        NSArray *a2 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a2) ;
        
        //使用in包含运算
        predicate = [NSPredicate predicateWithFormat:@"name IN  {'小明','小王'}"] ;
        NSArray *a3 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a3) ;
        
        //使用BEGINSWITH
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH '小'"] ;
        NSArray *a4 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a4) ;
        
        //使用ENDSWITH
        predicate = [NSPredicate predicateWithFormat:@"name ENDSWITH '王'"] ;
        NSArray *a5 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a5) ;
        
        //使用like *代表任意字符 ？代表一个字符
        predicate = [NSPredicate predicateWithFormat:@"name like '小*'"] ;
        NSArray *a6 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a6) ;
        
        predicate = [NSPredicate predicateWithFormat:@"name like '小?'"] ;
        NSArray *a7 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a7) ;
        
        //使用BETWEEN
        predicate = [NSPredicate predicateWithFormat:@"age BETWEEN {20,40}"] ;
        NSArray *a8 = [persons filteredArrayUsingPredicate:predicate] ;
        NSLog(@"%@",a8) ;
        
    }
    return 0;
}
