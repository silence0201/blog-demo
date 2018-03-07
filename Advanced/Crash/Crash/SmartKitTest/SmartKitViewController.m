//
//  SmartKitViewController.m
//  Crash
//
//  Created by Silence on 2018/3/7.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "SmartKitViewController.h"

@interface SmartKitViewController ()

@end

@implementation SmartKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)testSelector {
    NSLog(@"%s",__FUNCTION__);
}

// 执行一个存在的Selector
- (IBAction)selectorAction:(id)sender {
    [self performSelector:@selector(testSelector)];
}

// 错误,执行一个Unrecoginzed Selector
- (IBAction)unrecoginzedSelector:(id)sender {
    [self performSelector:@selector(test)];
}

@end
