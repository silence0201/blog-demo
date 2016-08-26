//
//  TestClass.m
//  NSInvocation
//
//  Created by 杨晴贺 on 8/26/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TestClass.h"
#import "NSObject+PerformSelector.h"

@implementation TestClass

- (void)test{
    [self myPerformSelector:@selector(call:) withObject:@[@"aaa"]] ;
}

- (void)call:(NSString *)str{
    NSLog(@"%@",str) ;
}

@end
