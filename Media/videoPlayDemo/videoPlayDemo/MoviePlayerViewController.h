//
//  MoviePlayerViewController.h
//  videoPlayDemo
//
//  Created by 杨晴贺 on 8/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoviePlayerViewController ;
@protocol MoviePlayerViewControllerDelegate <NSObject>

- (void)moviePlayerViewController:(MoviePlayerViewController *)vc didFinishCapturedImage:(UIImage *)image ;

@end

@interface MoviePlayerViewController : UIViewController

// 播放的URL
@property (nonatomic,strong) NSURL *movieURL;

// 设置截屏事件
@property (nonatomic,strong) NSArray *captureTimes;

// 设置代理
@property (nonatomic,weak) id<MoviePlayerViewControllerDelegate> delegate ;



@end
