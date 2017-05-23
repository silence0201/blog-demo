//
//  CircleView.m
//  TextKitDemo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect
{
    [self.tintColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect: self.bounds] fill];
}

@end
