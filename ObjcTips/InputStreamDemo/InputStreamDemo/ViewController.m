//
//  ViewController.m
//  InputStreamDemo
//
//  Created by 杨晴贺 on 2017/5/22.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "Reader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Test.txt" withExtension:nil] ;
    Reader *reader = [[Reader alloc]initWithFileAtURL:url] ;
    [reader enumerateLinesWithBlock:^(NSUInteger lineNumber, NSString *line) {
        NSLog(@"%ld:%@",lineNumber,line) ;
    } completionHandler:^(NSUInteger numberOfLines) {
        NSLog(@"总共行数%ld",numberOfLines) ;
    }] ;
}





@end
