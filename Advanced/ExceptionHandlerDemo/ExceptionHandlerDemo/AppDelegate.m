//
//  AppDelegate.m
//  ExceptionHandlerDemo
//
//  Created by 杨晴贺 on 2017/4/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [ExceptionHandler installExceptionHandler:YES] ;
    return YES;
}


@end
