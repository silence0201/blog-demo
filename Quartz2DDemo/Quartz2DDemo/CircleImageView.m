//
//  CircleImageView.m
//  Quartz2DDemo
//
//  Created by 杨晴贺 on 8/17/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CircleImageView.h"

@implementation CircleImageView

- (void)drawRect:(CGRect)rect{
    // 实现图片的剪切并显示
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    
    // 指定圆的路径
    CGRect imageRect = CGRectMake(0, 0, rect.size.width, rect.size.height) ;
    CGContextAddEllipseInRect(context, rect) ;
    CGContextClip(context) ;
    
    // 把图片进行显示
    UIImage *image = [UIImage imageNamed:_imageName] ;
    [image drawInRect:imageRect] ;
    
    // 添加圆的边框
    [_borderColor set] ;
    CGContextSetLineWidth(context, _borderWidth) ;
    
    CGContextAddEllipseInRect(context, imageRect) ;
    CGContextStrokePath(context) ;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName ;
    [self setNeedsDisplay] ;
}

@end
