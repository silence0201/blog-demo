//
//  main.m
//  mobileServiceDemo
//
//  Created by 杨晴贺 on 25/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceLister.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 创建一个服务监听对象
        ServiceLister *listener = [[ServiceLister alloc]init] ;
        
        // 开启监听
        [listener start] ;
        
        // 开启主运行循环,让服务能持续运行
        [[NSRunLoop mainRunLoop]run] ;
    }
    return 0;
}
