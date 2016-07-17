//
//  main.m
//  SingleDemo
//
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Singleton *s1 = [Singleton shareInstance] ;
        Singleton *s2 = [Singleton shareInstance] ;
        NSLog(@"s1:%p",s1) ;
        NSLog(@"s2:%p",s2) ;
    }
    return 0;
}
