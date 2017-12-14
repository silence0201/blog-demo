//
//  ViewController.m
//  UIDebugDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "UIApplication+UIDebug.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"显示调试窗口" style: UIBarButtonItemStylePlain target:self action:@selector(show)] ;
    self.navigationItem.rightBarButtonItem = item ;
    
    UIImage *image = [UIImage imageNamed:@"Demo"] ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    [self.view addSubview:imageView] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = image ;
    
    UIVisualEffectView *blur = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    blur.frame = imageView.bounds ;
    [imageView addSubview:blur] ;
    
}

- (void)show {
    [UIApplication showDebuggingInformationOverlay] ;
}



@end
