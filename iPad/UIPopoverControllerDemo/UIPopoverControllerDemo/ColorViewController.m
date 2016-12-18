//
//  ColorViewController.m
//  UIPopoverControllerDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ColorViewController.h"
#import "UIImage+GetColor.h"

@interface ColorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = self.imageView.image.size ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取用户点击的点
    CGPoint point = [[touches anyObject]locationInView:self.view] ;
    
    // 获取图片上point的颜色
    UIColor *selectColor = [self.imageView.image pixelColorAtLocation:point];
    
    if (self.selectColorBlock) {
        self.selectColorBlock(selectColor) ;
    }
}

@end
