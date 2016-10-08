//
//  UMSTabBarViewController.m
//  SocialSDK
//
//  Created by umeng on 16/4/25.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import "UMSTabBarViewController.h"
#import "UMSLoginTableViewController.h"
#import "UMSUserInfoTableViewController.h"
#import "UMShareContentViewController.h"


@interface UMSTabBarViewController ()

@end

@implementation UMSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UMShareContentViewController *shareVc = [[UMShareContentViewController alloc] init];
    shareVc.title = @"分享";
    shareVc.tabBarItem.image = [UIImage imageNamed:@"UMS_share"];
    UINavigationController *shareNavi = [[UINavigationController alloc] initWithRootViewController:shareVc];
    
    UMSLoginTableViewController *loginVc = [[UMSLoginTableViewController alloc] init];
    loginVc.title = @"授权";
    loginVc.tabBarItem.image = [UIImage imageNamed:@"UMS_account"];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVc];

    
    UMSUserInfoTableViewController *userInfoVc = [[UMSUserInfoTableViewController alloc] init];
    userInfoVc.title = @"用户资料";
    userInfoVc.tabBarItem.image = [UIImage imageNamed:@"UMS_bar"];
    UINavigationController *userInfoNavi = [[UINavigationController alloc] initWithRootViewController:userInfoVc];

//    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        shareVc.edgesForExtendedLayout = UIRectEdgeNone;
        loginVc.edgesForExtendedLayout = UIRectEdgeNone;
        userInfoVc.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.viewControllers = [NSArray arrayWithObjects:shareNavi, loginNavi, userInfoNavi, nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
