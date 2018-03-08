//
//  ObserverViewController.m
//  Crash
//
//  Created by 杨晴贺 on 2018/3/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ObserverViewController.h"

@interface ObserverViewController ()

@end

@implementation ObserverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    // If your app targets iOS 9.0 and later or macOS 10.11 and later, you don't need to unregister an observer in its dealloc method. Otherwise, you should call removeObserver:name:object: before observer or any object passed to this method is deallocated.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"noti" object:nil];
}

- (void)noti:(NSNotification*)noti {
    NSLog(@"hello");
}

- (void)dealloc {
    NSLog(@"ObserverViewController dealloc");
}
- (IBAction)post:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil];
}

@end
