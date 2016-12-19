//
//  AppDelegate.m
//  AutoLayoutDemo
//
//  Created by 杨晴贺 on 19/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[ViewController new]] ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
