//
//  ViewController.m
//  GPUImageFilterGroupDemo
//
//  Created by 杨晴贺 on 2017/5/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property (nonatomic,strong) GPUImageFilterGroup *filterGroup ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化输入源
    UIImage *inputImage = [UIImage imageNamed:@"Demo"] ;
    // 初始化picture
    GPUImagePicture *picture = [[GPUImagePicture alloc]initWithImage:inputImage] ;
    // 初始化imgaeView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    // 初始化filterGroup
    self.filterGroup = [[GPUImageFilterGroup alloc]init] ;
    [picture addTarget:self.filterGroup] ;
    
    // 添加 filter
    /**
     原理：
     1. filterGroup(addFilter) 滤镜组添加每个滤镜
     2. 按添加顺序（可自行调整）前一个filter(addTarget) 添加后一个filter
     3. filterGroup.initialFilters = @[第一个filter]];
     4. filterGroup.terminalFilter = 最后一个filter;
     
     */
    
    GPUImageRGBFilter *filter1         = [[GPUImageRGBFilter alloc] init];
    GPUImageToonFilter *filter2        = [[GPUImageToonFilter alloc] init];
    GPUImageColorInvertFilter *filter3 = [[GPUImageColorInvertFilter alloc] init];
    GPUImageSepiaFilter       *filter4 = [[GPUImageSepiaFilter alloc] init];
    [self addGPUImageFilter:filter1];
    [self addGPUImageFilter:filter2];
    [self addGPUImageFilter:filter3];
    [self addGPUImageFilter:filter4];
    
    // 处理图片
    [picture processImage];
    [_filterGroup useNextFrameForImageCapture];
    
    imageView.image = [_filterGroup imageFromCurrentFramebuffer] ;
}

- (void)addGPUImageFilter:(GPUImageOutput<GPUImageInput> *)filter{
    [_filterGroup addFilter:filter];
    GPUImageOutput<GPUImageInput> *newTerminalFilter = filter;
    NSInteger count = _filterGroup.filterCount;
    if (count == 1){
        _filterGroup.initialFilters = @[newTerminalFilter];
        _filterGroup.terminalFilter = newTerminalFilter;
        
    } else{
        GPUImageOutput<GPUImageInput> *terminalFilter    = _filterGroup.terminalFilter;
        NSArray *initialFilters                          = _filterGroup.initialFilters;
        [terminalFilter addTarget:newTerminalFilter];
        _filterGroup.initialFilters = @[initialFilters[0]];
        _filterGroup.terminalFilter = newTerminalFilter;
    }
}



@end
