//
//  MoviePlayerViewController.m
//  videoPlayDemo
//
//  Created by 杨晴贺 on 8/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerViewController ()

// 播放器控制器
@property(strong,nonatomic)MPMoviePlayerController *movieContr;

@end

@implementation MoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初化一个视频播放器
    MPMoviePlayerController *movieContr = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
    
    //设置movieContr的View的尺寸
    movieContr.view.frame = self.view.bounds;
    
    //设置视频播放的适配
    movieContr.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //把movieContr的View 添加到当前视频控制器的View
    [self.view addSubview:movieContr.view];
    
    //赋值
    self.movieContr = movieContr;
    
    // 准备播放
    [movieContr prepareToPlay] ;
    
    // 播放
    [movieContr play] ;
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter] ;
    // 设置Done的事件,通过通知的方式实现
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerDidExitFullscreenNotification object:nil] ;
    // 设置播放完成后的通知事件
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerPlaybackDidFinishNotification object:nil] ;
    
    // 截屏处理
    if(self.captureTimes){
       // 截屏处理
        [self.movieContr requestThumbnailImagesAtTimes:self.captureTimes timeOption:MPMovieTimeOptionExact] ;
    }
    
    // 监听截屏返回的图片
    [center addObserver:self selector:@selector(captureImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil] ;
    
    
}

#pragma mark - 通知事件

/**
 *  退出
 */
- (void)exit{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)captureImage:(NSNotification *)noti{
    // 通知代理对象进行更新操作
    if ([self.delegate respondsToSelector:@selector(moviePlayerViewController:didFinishCapturedImage:)]) {
        UIImage *img = noti.userInfo[MPMoviePlayerThumbnailImageKey] ;
        [self.delegate moviePlayerViewController:self didFinishCapturedImage:img] ;
    }
}



@end
