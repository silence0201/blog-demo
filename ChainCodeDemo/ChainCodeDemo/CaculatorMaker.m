//
//  CaculatorMaker.m
//  ChainCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

// 链式编程的思想:把要做的事情封装到block中,给外界提供返回这个blokc的方法
// 链式编程的思想特点:方法返回值必须是block,
// block的参数:放需要操作的内容,不咯查看的返回值返回方法的调用者
- (CaculatorMaker *(^)(int))add{
    return ^(int num){
        _result += num ;
        return self ;
    } ;
}

- (CaculatorMaker *(^)(int))multy{
    return ^(int num){
        _result *= num ;
        return self ;
    } ;
}
@end
