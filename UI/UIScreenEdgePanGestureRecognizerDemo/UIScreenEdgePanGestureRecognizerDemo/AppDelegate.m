//
//  AppDelegate.m
//  UIScreenEdgePanGestureRecognizerDemo
//
//  Created by 杨晴贺 on 2017/6/19.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.rootViewController = [[ViewController alloc]init] ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
