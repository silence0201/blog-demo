//
//  main.m
//  MultThreadDemo
//
//  Created by 杨晴贺 on 26/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>
#import "GCDDemo.h"
#import "OperationDemo.h"

void *demo(void *params){
    NSString *str = (__bridge NSString *)(params) ;
    NSLog(@"%@ - %@", [NSThread currentThread], str);
    return NULL ;
}

void pthreadDemo(){
    /**
     参数：
     1> 指向线程标识符的指针，C 语言中类型的结尾通常 _t/Ref，而且不需要使用 *
     2> 用来设置线程属性
     3> 线程运行函数的起始地址
     4> 运行函数的参数
     
     返回值：
     - 若线程创建成功，则返回0
     - 若线程创建失败，则返回出错编号
     */
    pthread_t threadId = NULL;
    NSString *str = @"Hello Pthread";
    int result = pthread_create(&threadId, NULL, demo, (__bridge void *)(str));
    
    if (result == 0) {
        NSLog(@"创建线程 OK");
    } else {
        NSLog(@"创建线程失败 %d", result);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // pthreadDemo() ;
        // [GCDDemo gcdDemo1] ;
        // [GCDDemo gcdDemo2] ;
        // [GCDDemo gcdDemo3] ;
        // [GCDDemo gcdDemo4] ;
        // [GCDDemo gcdDemo5] ;
        // [GCDDemo gcdDemo6] ;
        // [GCDDemo gcdDemo7] ;
        // [GCDDemo gcdDemo8] ;
        // [GCDDemo group1] ;
        
        // [OperationDemo OperationDemo1] ;
        // [OperationDemo OperationDemo2] ;
        [OperationDemo OperationDemo4] ;
        // [OperationDemo OperationDemo4] ;
    }
    return 0;
}
