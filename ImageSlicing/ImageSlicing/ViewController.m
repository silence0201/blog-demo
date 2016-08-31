//
//  ViewController.m
//  ImageSlicing
//
//  Created by 杨晴贺 on 8/30/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self noSlicing] ;
    // [self method1] ;
    // [self method2] ;
    // [self method3] ;

}

- (void)noSlicing{
    // 创建一个按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 60)] ;
    
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:@"backgroud"] forState:UIControlStateNormal] ;
    
    // 添加按钮
    [self.view addSubview:btn] ;
}

// ios5之前的方法
- (void)method1{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 60)] ;
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"backgroud"] ;
    
    // 设置左边端盖宽度
    NSInteger leftWidth = image.size.width * 0.5 ;
    // 设置上边的端盖高度
    NSInteger topHeight = image.size.height * 0.5 ;
    
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftWidth topCapHeight:topHeight] ;
    
    // 设置按钮的背景图片
    [btn setBackgroundImage:newImage forState:UIControlStateNormal] ;
    
    // 添加按钮
    [self.view addSubview:btn] ;
}

// ios5之后的方法
- (void)method2{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 60)] ;
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"backgroud"] ;
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5 ;
    CGFloat left = image.size.width * 0.5 ;
    CGFloat botton = image.size.height * 0.5 ;
    CGFloat right = image.size.width * 0.5 ;
    
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(top, left, botton, right) ;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInset] ;
    
    // 设置按钮的背景图片
    [btn setBackgroundImage:newImage forState:UIControlStateNormal] ;
    
    // 添加按钮
    [self.view addSubview:btn] ;
}

// ios5之后的方法
- (void)method3{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 60)] ;
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"backgroud"] ;
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5 ;
    CGFloat left = image.size.width * 0.5 ;
    CGFloat botton = image.size.height * 0.5 ;
    CGFloat right = image.size.width * 0.5 ;
    
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(top, left, botton, right) ;
    
    // 设置拉伸的模式
    // UIImageResizingModeTile,   平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
    // UIImageResizingModeStretch, 拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    UIImageResizingMode mode = UIImageResizingModeStretch ;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInset resizingMode:mode] ;
    
    // 设置按钮的背景图片
    [btn setBackgroundImage:newImage forState:UIControlStateNormal] ;
    
    // 添加按钮
    [self.view addSubview:btn] ;
}

@end
