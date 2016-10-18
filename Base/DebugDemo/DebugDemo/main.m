//
//  main.m
//  DebugDemo
//
//  Created by 杨晴贺 on 16/7/21.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Debug.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int sum = 0 ;
        for (int i = 0 ;i<100;i++){
            sum += i ;
            Debug *d = [[Debug alloc]init] ;
            [d test:i] ;
        }
    }
    return 0;
}

