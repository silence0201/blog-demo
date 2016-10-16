//
//  AppDelegate.m
//  NoticeDemo
//
//  Created by 杨晴贺 on 16/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter] ;
        center.delegate = self ;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"注册成功") ;
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@",settings) ;
                }] ;
            }else{
                NSLog(@"注册失败") ;
            }
        }] ;
    }else if([[UIDevice currentDevice].systemVersion floatValue] > 8){
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }else{
        //iOS8系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
    // 注册获取device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications] ;
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"Device Token:%@",deviceToken) ;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Error:%@",error) ;
}

// ios6以及以下系统收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"ios6以下收到通知:%@",userInfo) ;
}

// ios7-ios9 收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"ios7以上系统受到通知:%@",userInfo) ;
    completionHandler(UIBackgroundFetchResultNewData) ;
}

#pragma mark - UNUserNotificationCenterDelegate
// ios10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary *userInfo = notification.request.content.userInfo ;
    
    UNNotificationRequest *request = notification.request ;  // 收到的推送请求
    UNNotificationContent *content = request.content ;   // 收到的推送消息内容
    NSNumber *badge = content.badge ;   // 推送消息的角标
    NSString *body = content.body ;  // 推送消息体
    UNNotificationSound *sound = content.sound ;  // 推送消息的声音
    NSString *subtitle = content.subtitle ;   // 推送消息的副标题
    NSString *title = content.title ;   // 推送消息的标题
    
    // action
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"action1" options:UNNotificationActionOptionForeground] ;
    UNNotificationAction *action2 = [UNTextInputNotificationAction actionWithIdentifier:@"action2" title:@"action2" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"action2" textInputPlaceholder:@"action2"] ;
    
    //UNNotificationCategoryOptionNone
    //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
    //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
    
    UNNotificationCategory *catary = [UNNotificationCategory categoryWithIdentifier:@"catart" actions:@[action1,action2] intentIdentifiers:@[@"action1",@"action2"] options:UNNotificationCategoryOptionCustomDismissAction] ;
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:catary, nil]] ;
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS前台收到远程通知") ;
    }else{
        NSLog(@"收到本地通知") ;
    }
    
    completionHandler(UNNotificationPresentationOptionAlert) ; // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS前台收到远程通知") ;
    }else{
        NSLog(@"收到本地通知") ;
    }
    
    completionHandler();  // 系统要求执行这个方法
}

@end
