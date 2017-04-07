//
//  ViewController.m
//  CopyStrDemo
//
//  Created by 杨晴贺 on 2017/4/7.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSString *strongStr ;
@property (nonatomic,copy) NSString *copyedStr ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self stringDemo] ;
    NSLog(@"-----------分割线-----------") ;
    [self mutableStringDemo] ;
}

- (void)stringDemo {
    NSString *str = @"abc" ;
    self.strongStr = str ;
    self.copyedStr = str ;
    
    NSLog(@"原始字符串: %p",str) ;
    NSLog(@"Strong字符串: %p",_strongStr) ;
    NSLog(@"Copy字符串: %p",_copyedStr) ;
}

- (void)mutableStringDemo {
    NSMutableString *str = [NSMutableString stringWithFormat:@"abc"] ;
    
    self.strongStr = str ;
    self.copyedStr = str ;
    
    NSLog(@"原始字符串: %p",str) ;
    NSLog(@"Strong字符串: %p",_strongStr) ;
    NSLog(@"Copy字符串: %p",_copyedStr) ;
    
    [str appendString:@"tt"] ;
    NSLog(@"Strong: %@ , Copy: %@",_strongStr,_copyedStr) ;
}


@end
