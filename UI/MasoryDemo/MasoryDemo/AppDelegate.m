//
//  AppDelegate.m
//  MasoryDemo
//
//  Created by 杨晴贺 on 12/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]] ;
    self.window.rootViewController = nav ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
