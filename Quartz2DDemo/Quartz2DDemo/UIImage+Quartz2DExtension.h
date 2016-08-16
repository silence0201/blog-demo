//
//  UIImage+Quartz2DExtension.h
//  Quartz2DDemo
//
//  Created by 杨晴贺 on 8/16/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Quartz2DExtension)


/**
 *  生成一个带水印的图片
 *
 *  @param imageName      原图片名称
 *  @param waterImageName 水印图片名称
 *  @param scale          缩放比例
 *  @param waterScale     水印的缩放
 *  @return 有水印的图片
 */
- (UIImage *)waterImageWithImageName:(NSString *)imageName waterImageName:(NSString *)waterImageName scale:(CGFloat) scale waterScale:(CGFloat)waterScale;

/**
 *  裁剪圆形图片
 *
 *  @param image 图片
 *  @param inset 内间距
 *
 *  @return 裁剪后的图片
 */
- (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset ;

@end
