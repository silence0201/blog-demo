//
//  main.m
//  enumDemo
//
//  Created by 杨晴贺 on 16/7/18.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        EnumDemo *demo = [EnumDemo instance] ;
        [demo enumDemo];
        [demo optionDemo] ;
    }
    return 0;
}
