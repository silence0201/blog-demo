//
//  AppDelegate.m
//  UMAnalyticsDemo
//
//  Created by 杨晴贺 on 20/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <UMMobClick/MobClick.h>

#define UMENG_APPKEY @"585936b907fe655d260013fd"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UMConfigInstance.appKey = UMENG_APPKEY ;
    UMConfigInstance.channelId = @"Debug" ;
    
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    return YES;
}


@end
