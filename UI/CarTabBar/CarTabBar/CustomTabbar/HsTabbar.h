//
//  HsTabbar.h
//  CarTabBar
//
//  Created by 杨晴贺 on 06/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HsTabbar ;

@protocol HsTabbarDelegate <NSObject>

@optional
/** 点击对应的选项 */
- (void)tabBar:(HsTabbar *)tabBar didSelectInIndex:(long)index ;

@end

@interface HsTabbar : UIView

@property (nonatomic,weak) id<HsTabbarDelegate> delegate ;


/**
 添加TabBarButton

 @param tabBarItem Item
 */
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem ;

@end
