//
//  ViewController.m
//  ChainCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // block使代码高聚合
    int result = [NSObject makeCaculator:^(CaculatorMaker *make) {
        // 将代码封装到这里
        make.add(10).multy(20) ;
    }] ;
    NSLog(@"%d",result) ;
}

@end
