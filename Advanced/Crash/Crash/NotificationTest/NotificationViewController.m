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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil];
}



@end
