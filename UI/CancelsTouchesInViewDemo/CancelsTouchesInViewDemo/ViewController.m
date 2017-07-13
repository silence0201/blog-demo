//
//  ViewController.m
//  CancelsTouchesInViewDemo
//
//  Created by 杨晴贺 on 2017/7/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    button.backgroundColor = [UIColor colorWithRed:0.1 green:0.5 blue:0.4 alpha:1];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.cancelsTouchesInView = NO;  // 默认为YES
    [button addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"tap");
}

- (void)btnAction:(UIButton *)btn {
    NSLog(@"button");
}



@end
