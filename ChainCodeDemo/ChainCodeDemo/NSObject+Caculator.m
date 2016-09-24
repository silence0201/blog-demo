//
//  NSObject+Caculator.m
//  ChainCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+Caculator.h"


@implementation NSObject (Caculator)

+ (int)makeCaculator:(void(^)(CaculatorMaker *make))block{
    // 创建计算者对象
    CaculatorMaker *make = [[CaculatorMaker alloc]init] ;
    block(make) ;
    return make.result ;
}

@end
