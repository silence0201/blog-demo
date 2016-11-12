//
//  EqualMarginController.m
//  MasoryDemo
//
//  Created by 杨晴贺 on 12/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "EqualMarginController.h"
#import "UIView+EqualMargin.h"
#import "Masonry.h"

@interface EqualMarginController ()

@end

@implementation EqualMarginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"EqualMarginController" ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.image = [UIImage imageNamed:@"3"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    visualView.frame = [UIScreen mainScreen].bounds ;
    [imageView addSubview:visualView] ;
    
    [self equalMargin] ;
}

- (void)equalMargin{
    typeof(self) __weak weakSelf = self ;
    // 屏幕中间放一个300*300的红色View
    UIView *redView = [[UIView alloc]init] ;
    redView.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:redView] ;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300)) ;
        make.center.equalTo(weakSelf.view) ;
    }] ;
    
    // 在红色View放三个正方形View,间距为10
    NSInteger padding = 10 ;
    
    UIView *yellowView1 = [[UIView alloc]init] ;
    yellowView1.backgroundColor = [UIColor yellowColor] ;
    [redView addSubview:yellowView1] ;
    
    UIView *yellowView2 = [[UIView alloc]init] ;
    yellowView2.backgroundColor = [UIColor yellowColor] ;
    [redView addSubview:yellowView2] ;
    
    UIView *yellowView3 = [[UIView alloc]init] ;
    yellowView3.backgroundColor = [UIColor yellowColor] ;
    [redView addSubview:yellowView3] ;
    
    NSArray<UIView *>*views = @[yellowView1,yellowView2,yellowView3] ;
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding] ;
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(10) ;
        make.height.mas_equalTo(yellowView3.mas_width) ;
    }] ;
    
    // 在红色View里面放三个正方形蓝色,宽度为30,间距一样大
    UIView *blueView1 = [[UIView alloc]init] ;
    blueView1.backgroundColor = [UIColor blueColor] ;
    [redView addSubview:blueView1] ;
    
    UIView *blueView2 = [[UIView alloc]init] ;
    blueView2.backgroundColor = [UIColor blueColor] ;
    [redView addSubview:blueView2] ;
    
    UIView *blueView3 = [[UIView alloc]init] ;
    blueView3.backgroundColor = [UIColor blueColor] ;
    [redView addSubview:blueView3] ;
    
    NSArray<UIView *>*views2 = @[blueView1,blueView2,blueView3] ;
    [views2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:20 tailSpacing:20] ;
    [views2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yellowView3.mas_bottom).offset(20) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    // 在红色View里面放三个大小不一样的绿色正方形, 间隙等大, masonry并没提供相关方法
    NSMutableArray *greenViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *greenView = [[UIView alloc] init];
        greenView.backgroundColor = [UIColor greenColor];
        [redView addSubview:greenView];
        [greenViews addObject:greenView];
        [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(redView).offset(-10);
            make.width.mas_equalTo(i*20 + 20);
            make.height.mas_equalTo(greenView.mas_width);
        }];
    }
    [redView distributeSpacingHorizontallyWith:greenViews];
    
    
}

@end
