//
//  TimerControl.m
//  DelegateDemo
//
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "TimerControl.h"

@implementation TimerControl

- (void)startTheTimer{
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(timeProc) userInfo:nil repeats:NO];
}

// 定义方法对委托方进行调用
- (void)timeProc{
    if (self.updateAlterBlock) {
        //判断协议中是否实现了该方法
        if ([self.delegate respondsToSelector:@selector(updateAlter)]) {
            [self.delegate updateAlter] ;
        }
    }
}

@end
