//
//  Blueview.m
//  ThroughTest
//
//  Created by 杨晴贺 on 28/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Blueview.h"

@implementation Blueview

// 重写父类的方法,转发给同级的View处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *supView = self.superview ;
    for (UIView *view in supView.subviews) {
        if (view != self) {
            CGPoint otherPoint = [self convertPoint:point toView:view] ;
            if ([view pointInside:otherPoint withEvent:event]) {
                return view ;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
