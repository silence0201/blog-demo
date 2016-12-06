//
//  HsTabbar.m
//  CarTabBar
//
//  Created by 杨晴贺 on 06/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HsTabbar.h"
#import "HsTabbarButton.h"

@interface HsTabbar ()

@property (nonatomic,strong) NSMutableArray *tabBarButtonArray ;
@property (nonatomic,weak) HsTabbarButton *selectedButton ;

@end


@implementation HsTabbar

#pragma mark ---  init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor] ;
    }
    return self ;
}

- (void)layoutSubviews{
    [super layoutSubviews] ;
    CGFloat btnY = 0 ;
    CGFloat btnW = self.frame.size.width / self.subviews.count ;
    CGFloat btnH = self.frame.size.height ;
    for(NSInteger nIndex = 0 ;nIndex < self.tabBarButtonArray.count ; nIndex++){
        CGFloat btnX = btnW * nIndex ;
        HsTabbarButton *tabBarButton = self.tabBarButtonArray[nIndex] ;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
    }
}

#pragma mark --- Public Method
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    HsTabbarButton *tabBarButton = [[HsTabbarButton alloc]init] ;
    tabBarButton.tabBarItem = tabBarItem ;
    [tabBarButton addTarget:self action:@selector(clickTabBarButton:) forControlEvents:UIControlEventTouchUpInside] ;
    [self addSubview:tabBarButton] ;
    [self.tabBarButtonArray addObject:tabBarButton] ;
    
    if(self.tabBarButtonArray.count == 1){
        [self clickTabBarButton:tabBarButton] ;
    }
}

#pragma mark --- Action
- (void)clickTabBarButton:(HsTabbarButton *)tabBarBtn{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectInIndex:)]){
        [self.delegate tabBar:self didSelectInIndex:[self.tabBarButtonArray indexOfObject:tabBarBtn]] ;
    }
    self.selectedButton.selected = NO ;
    tabBarBtn.selected = YES ;
    self.selectedButton = tabBarBtn ;
}

#pragma mark --- Lazy Load
- (NSMutableArray *)tabBarButtonArray{
    if (!_tabBarButtonArray) {
        _tabBarButtonArray = [NSMutableArray array] ;
    }
    return _tabBarButtonArray ;
}

@end
