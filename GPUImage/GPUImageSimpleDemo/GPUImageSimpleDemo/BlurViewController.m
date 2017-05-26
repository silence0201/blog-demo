//
//  BlurViewController.m
//  GPUImageSimpleDemo
//
//  Created by 杨晴贺 on 2017/5/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "BlurViewController.h"
#import <GPUImage/GPUImage.h>

@interface BlurViewController ()

@end

@implementation BlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *inputImage = [UIImage imageNamed:@"Demo"] ;
    
    // 部分清晰的高斯模糊
    GPUImageGaussianSelectiveBlurFilter *gaussianBlurFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
    gaussianBlurFilter.blurRadiusInPixels = 5; // 模糊的程度 默认:5
    [gaussianBlurFilter forceProcessingAtSize:inputImage.size];
    
    [gaussianBlurFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:gaussianBlurFilter];
    //开始渲染
    [stillImageSource processImage];
    gaussianBlurFilter.excludeCirclePoint = CGPointMake(150, 150);
    gaussianBlurFilter.excludeBlurSize = 300.0;
    gaussianBlurFilter.excludeCircleRadius = 10;
    //获取渲染后的图片
    UIImage *newImage = [gaussianBlurFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = newImage ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView];
}

@end
