//
//  VignetteViewController.m
//  GPUImageSimpleDemo
//
//  Created by 杨晴贺 on 2017/5/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "VignetteViewController.h"
#import <GPUImage/GPUImage.h>


@interface VignetteViewController ()

@end

@implementation VignetteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *inputImage = [UIImage imageNamed:@"Demo"] ;
    
    GPUImageVignetteFilter *filter = [[GPUImageVignetteFilter alloc]init] ;
    
    // 设置需要渲染的区域
    [filter forceProcessingAtSize:inputImage.size] ;
    [filter useNextFrameForImageCapture] ;
    
    // 获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage] ;
    // 添加上滤镜
    [stillImageSource addTarget:filter] ;
    // 开始渲染
    [stillImageSource processImage] ;
    // 获取渲染后的图片
    UIImage *newImage = [filter imageFromCurrentFramebuffer] ;
    // 加载出来
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = newImage ;
    [self.view addSubview:imageView] ;
}

@end
