//
//  UIView+LabelHeight.h
//  labelHeightFit
//
//  Created by iOS002 on 15/11/25.
//  Copyright © 2015年 海涛旅游. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LabelHeight)

+ (CGFloat )getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;

@end
