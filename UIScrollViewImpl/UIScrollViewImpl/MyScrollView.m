//
//  MyScrollView.m
//  UIScrollViewImpl
//
//  Created by 杨晴贺 on 16/7/24.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan] ;
    }
    return self ;
}

- (void)panGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    //改变bounds
    CGPoint translation = [gestureRecognizer translationInView:self];
    CGRect bounds = self.bounds;
    CGFloat newBoundsOriginX = bounds.origin.x - translation.x;
    CGFloat minBoundsOriginX = 0.0;
    CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
    bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
    CGFloat newBoundsOriginY = bounds.origin.y - translation.y;
    CGFloat minBoundsOriginY = 0.0;
    CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
    bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
    
    self.bounds = bounds;
    [gestureRecognizer setTranslation:CGPointZero inView:self];
}

@end
