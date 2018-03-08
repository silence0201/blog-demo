//
//  NotificationViewController.m
//  Crash
//
//  Created by 杨晴贺 on 2018/3/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)post:(id)sender {
    // 给一个销毁的发送通知,发现在模拟器最低支持版本8.X上不存在闪退现象
    // 官方文档说明:在iOS9以后不用手动注销观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil];
}



@end
