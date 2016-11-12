//
//  BasicController.m
//  MasoryDemo
//
//  Created by 杨晴贺 on 12/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BasicController.h"
#import "Masonry.h"

@interface BasicController ()

@end

@implementation BasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"BasicController" ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    visualView.frame = [UIScreen mainScreen].bounds ;
    [imageView addSubview:visualView] ;
    
    [self basic] ;
}

- (void)basic{
    typeof(self) __weak weakSelf = self ;
    UIView *redView = [[UIView alloc]init] ;
    redView.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:redView] ;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(50+64) ;
        make.left.equalTo(weakSelf.view).offset(50) ;
        make.right.equalTo(weakSelf.view).offset(-50) ;
    }] ;
    
    UIView *greenView = [[UIView alloc]init] ;
    greenView.backgroundColor = [UIColor greenColor] ;
    [redView addSubview:greenView] ;
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(30) ;
        make.size.mas_equalTo(CGSizeMake(200, 200)) ;
        make.centerX.equalTo(redView) ;
    }] ;
    
    UILabel *label = [[UILabel alloc]init] ;
    label.backgroundColor = [UIColor orangeColor] ;
    label.numberOfLines = 0 ;
    label.text = @"等间距布局 - 从0开始说一下masonry的使用区别就是这里除了布局方向, 第一个和最后一个View的边距, 这里需要指定的是每个item的长度, 自动计算间隙, 所以这个要实现等间距, 其实是要通过item的数量" ;
    [redView addSubview:label] ;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(20) ;
        make.width.mas_equalTo(greenView) ;
        make.centerX.equalTo(greenView) ;
    }] ;
    
    [redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label).offset(20) ;
    }] ;
    
    
}

@end
