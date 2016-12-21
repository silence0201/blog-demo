//
//  DemoVC0.m
//  AutoLayoutDemo
//
//  Created by 杨晴贺 on 21/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DemoVC0.h"
#import "SDAutoLayout.h"

#define kTimeInterval 0.8


@implementation DemoVC0{
    NSTimer *_timer ;
    CGFloat _widthRatio ;
    UIView *_view0 ;
    UIView *_view5 ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    _widthRatio = 0.4 ;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(animation) userInfo:nil repeats:YES] ;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UIView *view0 = [[UIView alloc]init] ;
    view0.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:view0] ;
    view0.sd_layout
    .leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,80)
    .heightIs(130)
    .widthRatioToView(self.view, _widthRatio);
    _view0 = view0 ;
    
    UIView *view1 = [[UIView alloc]init] ;
    view1.backgroundColor = [UIColor yellowColor] ;
    [self.view addSubview:view1] ;
    view1.sd_layout
    .leftSpaceToView(view0,20)
    .topEqualToView(view0)
    .heightIs(60)
    .widthRatioToView(view0,0.5) ;
    
    UIView *view2 = [[UIView alloc]init] ;
    view2.backgroundColor = [UIColor blueColor] ;
    [self.view addSubview:view2] ;
    view2.sd_layout
    .leftSpaceToView(view1,10)
    .topEqualToView(view1)
    .heightRatioToView(view1,1)
    .widthIs(50) ;
    
    UIView *view3 = [[UIView alloc]init] ;
    view3.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:view3] ;
    view3.sd_layout
    .leftEqualToView(view1)
    .topSpaceToView(view1, 10)
    .heightRatioToView(view1, 1)
    .widthRatioToView(view1, 1);
    
    UIView *view4 = [[UIView alloc]init] ;
    view4.backgroundColor = [UIColor greenColor] ;
    [self.view addSubview:view4] ;
    view4.sd_layout
    .leftEqualToView(view2)
    .topEqualToView(view3)
    .heightRatioToView(view3, 1)
    .widthRatioToView(view2, 1);
    
    UIView *view5 = [[UIView alloc]init] ;
    view5.backgroundColor = [UIColor blueColor] ;
    _view5 = view5 ;
    [view0 addSubview:view5] ;
    view5.sd_layout
    .centerYEqualToView(view0)
    .rightSpaceToView(view0, 10)
    .widthRatioToView(view0, 0.5)
    .heightIs(20);
    
}

- (void)animation{
    if (_widthRatio >= 0.4) {
        _widthRatio = 0.1;
    } else {
        _widthRatio = 0.4;
    }
    
    // 开启动画
    [UIView animateWithDuration:0.8 animations:^{
        _view0.sd_layout
        .widthRatioToView(self.view, _widthRatio);
        [_view0 updateLayout]; // 调用此方法开启view0动画效果
        [_view5 updateLayout]; // 调用此方法开启view5动画效果
        /*
         调用[self.view0 updateLayout]就可以实现view0和其它兄弟view一起动画，view0和view5是父子关系，如果view0需要动画要再主动调用一次[self.view5 updateLayout]
         */
    }];
}


@end
