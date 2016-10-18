//
//  main.m
//  sortDemo
//  用oc实现基本的排序
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
void bubleSort() ;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        bubleSort() ;
    }
    return 0;
}

/**
 *  简单实现冒泡算法
 */
void bubleSort(){
    NSMutableArray *arr = [@[@(1),@(7),@(4),@(7),@(3)] mutableCopy] ;
    
    for (int i = 0; i < arr.count-1; i++) {
        for (int j = i; j <= arr.count-1; j++) {
            if ([arr[i]intValue] > [arr[j] intValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:i] ;
            }
        }
    }
    NSLog(@"%@",arr) ;
    
}