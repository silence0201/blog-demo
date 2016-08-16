//
//  UIImage+Quartz2DExtension.m
//  Quartz2DDemo
//
//  Created by 杨晴贺 on 8/16/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIImage+Quartz2DExtension.h"

@implementation UIImage (Quartz2DExtension)

- (UIImage *)waterImageWithImageName:(NSString *)imageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale waterScale:(CGFloat)waterScale{
    // 创建一个背景图片
    UIImage *image = [UIImage imageNamed:imageName] ;
    
    // 创建一个图像上下文,开启上下文
    // size:位图的大小
    // alpha通道 YES不透明  NO透明  使用NO生成的更加清晰
    // scale 比例,设置0.0为屏幕的比例
    UIGraphicsBeginImageContextWithOptions(image.size, NO, scale) ;
    
    // 画背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)] ;
    
    // 画水印图片
    UIImage *waterImage = [UIImage imageNamed:waterImageName] ;
    
    // 计算水印图片的位置
    CGFloat waterW = waterImage.size.width * waterScale ;
    CGFloat waterH = waterImage.size.height * waterScale ;
    CGFloat waterX = image.size.width - waterW ;
    CGFloat waterY = image.size.height - waterH ;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)] ;
    
    // 从位图上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext() ;
    
    // 结束当当前位置的编辑
    UIGraphicsEndImageContext() ;
    
    return newImage ;
}

@end
