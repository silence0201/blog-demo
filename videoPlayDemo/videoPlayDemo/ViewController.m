//
//  ViewController.m
//  videoPlayDemo
//
//  Created by 杨晴贺 on 8/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MoviePlayerViewController.h"

@interface ViewController ()<MoviePlayerViewControllerDelegate>
// 显示截图的View
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 点击触发事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 初始化Controller
    MoviePlayerViewController *moviceVc = [[MoviePlayerViewController alloc]init] ;
    
    // 设置播放的View
    moviceVc.movieURL = [[NSBundle mainBundle] URLForResource:@"test.mp4" withExtension:nil] ;
    
    // 设置截屏的时间
    moviceVc.captureTimes = @[@(2.0)] ;
    
    // 设置代理
    moviceVc.delegate = self ;
    
    // 弹出控制器
    [self presentViewController:moviceVc animated:YES completion:nil] ;
}

#pragma mark - MoviePlayerViewControllerDelegate的代理方法
/**
 *  完成截图后进行的操作
 *
 *  @param image 获得的截图
 */
- (void)moviePlayerViewController:(MoviePlayerViewController *)vc didFinishCapturedImage:(UIImage *)image{
    // 显示截图
    self.imageView.image = image ;
}

@end
