//
//  main.m
//  FunctionalCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Caculator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 函数式编程:把一个操作写成一系列的方法
        Caculator *caculator = [[Caculator alloc]init] ;
        
        BOOL isEqual = [[[caculator add:^int(int result) {
            // 把计算过程写到Block中
            result += 10 ;
            result += 20 ;
            result += 30 ;
            result += 40 ;
            
            return result ;
        }] equal:^BOOL(int result) {
            return result == 100 ;
        }]isEqual] ;
        NSLog(@"%d",isEqual) ;
    }
    return 0;
}
