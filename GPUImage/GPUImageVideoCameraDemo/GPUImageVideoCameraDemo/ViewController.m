//
//  ViewController.m
//  GPUImageVideoCameraDemo
//
//  Created by 杨晴贺 on 2017/5/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property (nonatomic,strong) GPUImageView *imageView ;
@property (nonatomic,strong) GPUImageVideoCamera *videoCamera ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[GPUImageView alloc]initWithFrame:self.view.bounds] ;
    
    self.imageView.fillMode = kGPUImageFillModeStretch ;
    self.videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack] ;
    
    GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc]init] ;
    [self.videoCamera addTarget:filter] ;
    [filter addTarget:self.imageView] ;
    
    [self.videoCamera startCameraCapture] ;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.videoCamera.outputImageOrientation = orientation;
}


@end
