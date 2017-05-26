//
//  GaussianBlurViewController.m
//  GPUImageSimpleDemo
//
//  Created by 杨晴贺 on 2017/5/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "GaussianBlurViewController.h"
#import <GPUImage/GPUImage.h>

@interface GaussianBlurViewController ()

@end

@implementation GaussianBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *inputImage = [UIImage imageNamed:@"Demo"] ;
    
    GPUImageGaussianBlurFilter *gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    [gaussianBlurFilter forceProcessingAtSize:CGSizeMake(200, 300)];
    [gaussianBlurFilter useNextFrameForImageCapture];
    gaussianBlurFilter.blurRadiusInPixels = 1.0 ;
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:gaussianBlurFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [gaussianBlurFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = newImage ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView];
}

@end
