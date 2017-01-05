//
//  NSString+Test.h
//  HTlvyou_ERP
//
//  Created by Developer on 15/8/7.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//  字符格式验证

#import <Foundation/Foundation.h>

@interface NSString (Test)
    // 是否为有效的手机号
- (BOOL)isValidateMobile;

    // 是否为有效的邮箱号
- (BOOL)isValidateEmail;

    // 是否为有效的数字
- (BOOL)isValidateNum;

    // 是否为有效的产品价格
- (BOOL)isVAlidatePrice;

    // 是否为有效的电话号码
- (BOOL)isValidateTel;

@end
