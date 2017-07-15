//
//  ViewController.m
//  SegmentationDemo
//
//  Created by 杨晴贺 on 2017/7/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Segmentation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"我是一串基本的文本." ;
    NSArray *texts = [str segment:SegmentationOptionsKeepSymbols];
    NSLog(@"%@",texts);
    
}


@end
