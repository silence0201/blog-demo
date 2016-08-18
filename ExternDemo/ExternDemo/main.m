//
//  main.m
//  ExternDemo
//
//  Created by 杨晴贺 on 8/18/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "De.h"
#define Account @"小明"
#define Password @"123456"

// 字符串常量
static NSString *const account = @"小明" ;
static NSString *const password = @"123456" ;

// 宏定义使用
void macroDemo(){
    NSLog(@"%@====%@",Account,Password) ;
}

// 字符串常量的使用
void constDemo(){
    NSLog(@"%@====%@",account,password) ;
}

//const 修饰符的使用
void constDecorate(){
    // 变量
    int a = 10 ;
    // 可以修改
    a = a + 10 ;
    NSLog(@"%d",a) ;
    
    // 定义常量
    const int b = 10 ;
    int const bb = 10 ;  // 这种修饰上面的那种修饰等价
    //b = b + 10 ;   // 不能进行改变
    NSLog(@"%d",b) ;
    
    // 指针
    int *p = &a ;
    int c = 10 ;
    p = &c ;    // 指针可以重新被赋值
    *p = 20 ;   // 指针指向的值可以改变
    
    // 增加修饰符
    const int *q = 10 ;
    int const *qq = 10 ;  // 这种写法与上面那种写法相同,指定的值不能进行改变
//    *q = 20 ;   // 不能改变
    q = &c ;   // 地址可以改变
    
    int * const w = 10 ;
//    w = &c ;  // 地址是常量,不能改变
    *w = 20 ;
    
    const int * const p1 = 10 ;
    int const * const p2 = 10 ;
//    p1 = &a ;  都是常量,不能改变
//    *p1 = 20 ;
    
}
void test(){
    NSLog(@"%@",age) ;
    age = @"20" ;
}

int main(int argc, const char * argv[]) {
//    macroDemo() ;
//    constDemo() ;
    test() ;
    NSLog(@"%@",age) ;
    return 0;
}


