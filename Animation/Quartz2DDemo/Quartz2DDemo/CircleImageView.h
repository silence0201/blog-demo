//
//  CircleImageView.h
//  Quartz2DDemo
//
//  Created by 杨晴贺 on 8/17/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleImageView : UIView

/**
 *  图片的名称
 */
@property (nonatomic,copy) NSString *imageName ;

/**
 *  边框的颜色
 */
@property (nonatomic,strong) UIColor *borderColor;

/**
 *  边框的宽度
 */
@property (nonatomic,assign) CGFloat borderWidth;


@end
