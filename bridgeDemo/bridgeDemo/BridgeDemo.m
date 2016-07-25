//
//  BridgeDemo.m
//  bridgeDemo
//
//  Created by 杨晴贺 on 16/7/25.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "BridgeDemo.h"

@implementation BridgeDemo


- (void)bridgeDemo{
    NSString *strOC = [NSString stringWithFormat:@"demo"] ;
    // 没有交出所有权
    CFStringRef strC = (__bridge CFStringRef)strOC ;
    NSLog(@"%@ %@",strOC,strC) ;
    NSLog(@"%p %p",strOC,strC) ;
}

- (void)bridgeRetainedDemo{
    NSString *strOC = [NSString stringWithFormat:@"demo2"] ;
    // 将所有权交给了c语言
//    CFStringRef strC = (__bridge_retained CFStringRef)strOC ;
    CFStringRef strC = CFBridgingRetain(strOC) ;  //与上句含义相同
    CFRelease(strC) ;  //需要自己进行内存管理
    NSLog(@"%@ %@",strOC,strC) ;
    NSLog(@"%p %p",strOC,strC) ;
}

- (void)rBridgeDemo{
    CFStringRef strC = CFStringCreateWithCString(CFAllocatorGetDefault(), "demo", kCFStringEncodingASCII);
    NSString *strOC = (__bridge NSString *)strC;
//    CFRelease(strC);   果strC释放了,strOC也不能用了
    NSLog(@"%@ %@",strOC,strC) ;
    NSLog(@"%p %p",strOC,strC) ;
}

- (void)rBridgeTransferDemo{
    CFStringRef strC = CFStringCreateWithCString(CFAllocatorGetDefault(), "12345678", kCFStringEncodingASCII);
    //     NSString *strOC = (__bridge_transfer NSString *)strC;
    NSString *strOC = CFBridgingRelease(strC); // 这一句, 就等同于上一句
    NSLog(@"%@ %@",strOC,strC) ;
    NSLog(@"%p %p",strOC,strC) ;
}

// MRC模式
- (void)bridgeInMRCDemo{
    // 将Foundation对象转换为Core Foundation对象，直接强制类型转换即可
    NSString *strOC1 = [NSString stringWithFormat:@"xxxxxx"];
    CFStringRef strC1 = (CFStringRef)strOC1;
    NSLog(@"%@ %@", strOC1, strC1);
    [strOC1 release];
    CFRelease(strC1);
    
    // 将Core Foundation对象转换为Foundation对象，直接强制类型转换即可
    CFStringRef strC2 = CFStringCreateWithCString(CFAllocatorGetDefault(), "12345678", kCFStringEncodingASCII);
    NSString *strOC2 = (NSString *)strC2;
    NSLog(@"%@ %@", strOC2, strC2);
    [strOC2 release];
    CFRelease(strC2);
}

@end
