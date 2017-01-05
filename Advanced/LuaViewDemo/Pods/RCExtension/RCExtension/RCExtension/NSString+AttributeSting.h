//
//  NSString+AttributeSting.h
//  HTlvyou_ERP
//
//  Created by Developer on 16/1/20.
//  Copyright © 2016年 海涛旅游. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (AttributeSting)

/**
 *  获取AttributedString
 *
 *  @param str       full string
 *  @param subStr    sub string
 *  @param fontSize  subStr fontSize
 *  @param wordColor subStr wordColor
 *
 *  @return AttributedString
 */
+ (NSMutableAttributedString*)attributeStringWithString:(NSString *)str subStr:(NSString *)subStr fontSize:(CGFloat)fontSize color:(UIColor*)wordColor;

@end
