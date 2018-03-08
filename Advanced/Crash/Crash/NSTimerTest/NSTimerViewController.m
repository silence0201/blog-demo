//
//  NSTimerViewController.m
//  Crash
//
//  Created by Silence on 2018/3/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
//    if (self.timer) {
//        [self.timer invalidate];   // 移除runloop
//        self.timer = nil ;   // 解决循环引用
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)fire:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(fireTimer:) userInfo:@{@"Test":@"Hello,World"} repeats:YES];
}

- (void)fireTimer:(NSTimer *)timer {
    NSLog(@"userinfo is %@",timer.userInfo);
}

-(void)dealloc {
    NSLog(@"NSTimerViewController dealloc");
}

@end
