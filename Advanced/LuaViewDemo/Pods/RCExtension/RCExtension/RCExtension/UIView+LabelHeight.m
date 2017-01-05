//
//  UIView+LabelHeight.m
//  HTlvyou_ERP
//
//  Created by Developer on 15/11/26.
//  Copyright © 2015年 海涛旅游. All rights reserved.
//  获取label高度

#import "UIView+LabelHeight.h"

@implementation UIView (LabelHeight)

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    if (title.length > 1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 25)];
        label.font = font;
        label.numberOfLines = 0;
        label.text = title;
        [label sizeToFit];
        return CGRectGetHeight(label.frame) + 8;
    }
    return 25;
}

@end
