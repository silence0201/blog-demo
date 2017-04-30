//
//  ViewController.m
//  NoticeDemo
//
//  Created by 杨晴贺 on 16/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self requestLoactionNotification] ;
}

// 发送本地通知
- (void)requestLoactionNotification{
    // 创建Content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"本地推送测试";
    content.subtitle = @"推送测试";
    content.body = @"对IOS10新的SDK本地推送进行测试";
    content.badge = @1;
    
    NSError *error = nil ;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"jpg"] ;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    /* 附件通知键值使用说明*/
    // 1.UNNotificationAttachmentOptionsTypeHintKey
    dict[UNNotificationAttachmentOptionsTypeHintKey] = (__bridge id _Nullable)(kUTTypeImage);
    
    // 2.UNNotificationAttachmentOptionsThumbnailHiddenKey
    dict[UNNotificationAttachmentOptionsThumbnailHiddenKey] =  @YES;
    
    // 3.UNNotificationAttachmentOptionsThumbnailClippingRectKey
    //    Rect对应的意思
    //    thumbnailClippingRect =     {
    //        Height = "0.1";
    //        Width = "0.1";
    //        X = 0;
    //        Y = 0;
    //    };
    dict[UNNotificationAttachmentOptionsThumbnailClippingRectKey] = (__bridge id _Nullable)((CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1 ,1))));

    //   4. UNNotificationAttachmentOptionsThumbnailTimeKey-选取影片的某一秒做推送显示的缩略图
    dict[UNNotificationAttachmentOptionsThumbnailTimeKey] =@10;
    
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:dict error:&error];
    
    if(error){
        NSLog(@"出错啦:%@",error) ;
    }
    
    content.attachments = @[att] ;
    content.launchImageName = @"2" ;
    
    // 设置actegory,与之前对应
    content.categoryIdentifier = @"catart" ;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound] ;
    content.sound = sound ;
    
    /*UNTimeIntervalNotificationTrigger*/
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    
    /*UNCalendarNotificationTrigger*/
    // 周一早上 8：00 上班
//    NSDateComponents *components = [[NSDateComponents alloc] init];
    // 注意，weekday是从周日开始的，如果想设置为从周一开始，大家可以自己想想~
//    components.weekday = 2;
//    components.hour = 8;
//    UNCalendarNotificationTrigger *trigger2 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    /*UNLocationNotificationTrigger这个方法一般要先#import<CoreLocation/CoreLocation.h>*/
    
    /*这个触发条件一般在
     //1、如果用户进入或者走出某个区域会调用下面两个方法
     - (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
     - (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region代理方法反馈相关信息
     */
    
//    CLRegion *region = [[CLRegion alloc] init];
    
//    UNLocationNotificationTrigger *trigger3 = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES] ;
    
    // 创建本地通知
    NSString *requestIdentifer = @"TestRequestww1";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger1];
    
    //把通知加到UNUserNotificationCenter, 到指定触发点会被触发
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"触发完成") ;
    }];
    
}

@end
