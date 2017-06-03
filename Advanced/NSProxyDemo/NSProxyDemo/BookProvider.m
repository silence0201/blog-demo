//
//  BookProvider.m
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "BookProvider.h"

@interface BookProvider ()<BookProviderProtocol>

@end

@implementation BookProvider

- (void)purchaseBookWithTitle:(NSString *)bookTitle{
    NSLog(@"You've bought \"%@\"",bookTitle);
}

@end
