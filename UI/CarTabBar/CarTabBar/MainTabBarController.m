//
//  MainTabBarController.m
//  CarTabBar
//
//  Created by 杨晴贺 on 06/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainTabBarController.h"
#import "HsTabbar.h"
#import "HsTabbarButton.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()<HsTabbarDelegate>

@property (nonatomic,weak) HsTabbar *mainTabBar ;


@property (nonatomic,strong) FirstViewController *firstViewController ;
@property (nonatomic,strong) SecondViewController *secondViewController ;
@property (nonatomic,strong) ThirdViewController *thirdViewController ;

@end

@implementation MainTabBarController

#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainTabBar] ;
    [self setupControllers] ;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    for(UIView *child in self.tabBar.subviews){
        if([child isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [child removeFromSuperview] ;
        }
    }
}

#pragma mark --- 设置TabBar
- (void)setupMainTabBar{
    HsTabbar *mainTabBar = [[HsTabbar alloc]initWithFrame:self.tabBar.bounds] ;
    mainTabBar.delegate = self ;
    [self.tabBar addSubview:mainTabBar] ;
    _mainTabBar = mainTabBar ;
}

#pragma mark --- 设置子控制器
- (void)setupControllers{
    NSArray *images = @[@"mean_baoce",@"mean_Customized-line",@"mean_center"] ;
    NSArray *selectedImages = @[@"mean_baoce_active",@"mean_Customized-line_active",@"mean_center_active"] ;
    
    FirstViewController *firstViewController = [FirstViewController new] ;
    self.firstViewController = firstViewController ;
    
    SecondViewController *secondViewController = [SecondViewController new] ;
    self.secondViewController = secondViewController ;
    
    ThirdViewController *thirdViewController = [ThirdViewController new] ;
    self.thirdViewController = thirdViewController ;
    
    NSArray *viewControllers = @[firstViewController,secondViewController,thirdViewController] ;
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self setupChildVc:childVc image:images[i] selectedImage:selectedImages[i]];
    }
}

// 设置对应TabbarButton
- (void)setupChildVc:(UIViewController *)childVc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:childVc] ;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName] ;
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName] ;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem] ;
    [self addChildViewController:nav] ;
}

#pragma mark --- HsTabbarDelegate
- (void)tabBar:(HsTabbar *)tabBar didSelectInIndex:(long)index{
    self.selectedIndex = index ;
}

@end
