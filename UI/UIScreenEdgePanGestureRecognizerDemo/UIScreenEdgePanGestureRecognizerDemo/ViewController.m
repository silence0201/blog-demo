//
//  ViewController.m
//  UIScreenEdgePanGestureRecognizerDemo
//
//  Created by 杨晴贺 on 2017/6/19.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    CGFloat _centerX ;
    CGFloat _centerY ;
    UIView *_backgroundView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 存储坐标
    _centerX = self.view.bounds.size.width / 2 ;
    _centerY = self.view.bounds.size.height / 2;
    self.view.backgroundColor = [UIColor blackColor] ;
    
    // 屏幕边缘的pan手势(优先级高于其他手势)
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftEdgeGesture:)] ;
    edgePanGesture.edges = UIRectEdgeLeft ;  // 屏幕左侧边缘响应
    [self.view addGestureRecognizer:edgePanGesture] ;  // 给self.view添加上
    
    // 设置一个UIView用来替代self.view
    _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds] ;
    _backgroundView.backgroundColor = [UIColor yellowColor] ;
    [self.view addSubview:_backgroundView] ;
    
    // 展示的View
    UIView *showView_01 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)] ;
    showView_01.tag = 0x1 ;
    showView_01.backgroundColor = [UIColor redColor];
    [_backgroundView addSubview:showView_01] ;
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // 获取到当前被触摸的view
    UIView *view = [self.view hitTest:[gesture locationInView:gesture.view]
                            withEvent:nil];
    
    NSLog(@"tag = %ld", (long)view.tag);
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state){
        // 根据被触摸手势的view计算得出坐标值
        CGPoint translation = [gesture translationInView:gesture.view];
        NSLog(@"%@", NSStringFromCGPoint(translation));
        NSLog(@"进行中");
        // 进行设置
        _backgroundView.center = CGPointMake(_centerX + translation.x, _centerY);
    }else{
        // 恢复设置
        [UIView animateWithDuration:.3 animations:^{
            _backgroundView.center = CGPointMake(_centerX, _centerY);
        }];
    }
}



@end
