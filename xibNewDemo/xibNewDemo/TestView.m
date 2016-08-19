//
//  TestView.m
//  xibNewDemo
//
//  Created by 杨晴贺 on 8/19/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TestView.h"

// 可以对界面进行预览
// 可以通过代码控制界面的显示
IB_DESIGNABLE
@implementation TestView


- (void)drawRect:(CGRect)rect {
    UIBezierPath *firtPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 180, 180)];
    CAShapeLayer *shapeL = [CAShapeLayer layer];
    shapeL.lineWidth = 20;
    shapeL.path =firtPath.CGPath;
    shapeL.strokeStart = 0;
    shapeL.strokeEnd = 1;
    shapeL.strokeColor = [UIColor yellowColor].CGColor;
    shapeL.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeL];
    self.layer.cornerRadius = 30;
    self.layer.masksToBounds = YES;
}

@end
