//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by 杨晴贺 on 10/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MyWebViewController.h"


@interface ViewController ()

@property (nonatomic,strong) UIButton *btn ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem] ;
    btn.frame = CGRectMake(0, 0, 100, 50) ;
    btn.center = self.view.center ;
    [btn setTitle:@"进入" forState:UIControlStateNormal] ;
    [btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:btn] ;
}

- (void)go:(UIButton *)button{
    MyWebViewController *webView = [[MyWebViewController alloc]init] ;
    webView.urlString = @"https://github.com/silence0201" ;
    [self.navigationController pushViewController:webView animated:YES] ;
}


@end
