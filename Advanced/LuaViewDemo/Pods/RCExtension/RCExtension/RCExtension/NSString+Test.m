//
//  NSString+Test.m
//  HTlvyou_ERP
//
//  Created by Developer on 15/8/7.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

#import "NSString+Test.h"

@implementation NSString (Test)


- (BOOL)isValidateName{
    NSString *regex = @"^[a-zA-Z0-9\u4E00-\u9FA5]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidateContract {
    NSString *regex = @"^[a-zA-Z0-9]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isVAlidatePrice {
  NSString *regex = @"^[0-9]+(.[0-9]{1,3})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidateNum {
    return [self checkCode:self];
}

//判断验证码长度
- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)checkCode:(NSString *)text
{
    BOOL isMatch = (text.length == 6);
    //是否是纯数字
    if (isMatch) {
        isMatch = [self isAllNum:text];
    }
    if (! isMatch) {

        return NO;
    }
    return YES;
}

// 检验手机号
- (BOOL)isValidateMobile
{
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[6-8]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidateTel {
    NSString *regex = @"^[0-9]{3,4}-[0-9]{5,10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

// 验证邮箱
-(BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
