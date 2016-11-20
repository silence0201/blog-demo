//
//  MyScrollView.m
//  FullPopDemo
//
//  Created by 杨晴贺 on 20/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

// 相应全屏滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    NSLog(@"%s",__func__) ;
    if (self.contentOffset.x <= 0) {
        if([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]){
            return YES ;
        }
    }
    return NO ;
}

@end
