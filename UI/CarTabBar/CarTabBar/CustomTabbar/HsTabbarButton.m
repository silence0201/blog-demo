//
//  HsTabbarButton.m
//  CarTabBar
//
//  Created by 杨晴贺 on 06/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HsTabbarButton.h"

#define TOP_MARGIN 8
#define LEFT_MARGIN 10

@implementation HsTabbarButton

#pragma mark ---  init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        self.imageView.contentMode = UIViewContentModeScaleAspectFit ;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(-3, 8, 1, 33)] ;
        self.titleLabel.hidden = YES ;
        lineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] ;
        [self addSubview:lineView] ;
    }
    return self ;
}

#pragma mark --- Set Style
- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = LEFT_MARGIN ;
    CGFloat imageY = TOP_MARGIN ;
    CGFloat imageW = self.frame.size.width - 2 * LEFT_MARGIN ;
    CGFloat imageH = self.frame.size.height - 2 * TOP_MARGIN ;
    
    return CGRectMake(imageX, imageY, imageW, imageH) ;
}

#pragma mark --- Set
- (void)setTabBarItem:(UITabBarItem *)tabBarItem{
    _tabBarItem = tabBarItem ;
    
    [self setImage:tabBarItem.image forState:UIControlStateNormal] ;
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected] ;
}

@end
