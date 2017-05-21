//
//  AppDelegate.m
//  CICategoryList
//
//  Created by 杨晴贺 on 2017/5/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    ViewController *vc = [[ViewController alloc]init] ;
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc] ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
