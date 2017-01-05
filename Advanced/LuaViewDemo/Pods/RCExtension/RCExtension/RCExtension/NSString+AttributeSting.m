//
//  NSString+AttributeSting.m
//  HTlvyou_ERP
//
//  Created by Developer on 16/1/20.
//  Copyright © 2016年 海涛旅游. All rights reserved.
//


#import "NSString+AttributeSting.h"

@implementation NSString (AttributeSting)

+ (NSMutableAttributedString *)attributeStringWithString:(NSString *)str subStr:(NSString *)subStr fontSize:(CGFloat)fontSize color:(UIColor*)wordColor{

    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:subStr];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:wordColor,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:range];
    return attributeText;
}

@end
