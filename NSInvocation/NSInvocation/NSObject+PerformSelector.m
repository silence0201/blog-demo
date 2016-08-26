//
//  NSObject+PerformSelector.m
//  NSInvocation
//
//  Created by 杨晴贺 on 8/26/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+PerformSelector.h"

@implementation NSObject (PerformSelector)

- (id)myPerformSelector:(SEL)aSelector withObject:(NSArray *)objects{
    // 创建签名对象
    NSMethodSignature *signature = [[self class]instanceMethodSignatureForSelector:aSelector] ;
    
    // 判断传入的方法是否存在
    if (signature == nil) {
        // 传入的方法不存在,报异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:未定义方法",[self class],NSStringFromSelector(aSelector)] ;
        @throw [[NSException alloc] initWithName:@"没有指定的方法" reason:info userInfo:nil];
        
        return nil ;
    }
    
    // 创建NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature] ;
    
    // 保存方法所属的对象
    invocation.target = self ;
    invocation.selector = aSelector ;
    
    // 设置参数
    NSInteger arguments = signature.numberOfArguments - 2 ;
    
    // 不能直接进行遍历
    
    NSUInteger objectCount = objects.count ;
    
    NSInteger count = MIN(arguments,objectCount) ;
    
    
    for (int i = 0; i < count; i++) {
        NSObject *obj = objects[i] ;
        if([obj isKindOfClass:[NSNull class]]){
            obj = nil ;
        }
        [invocation setArgument:&obj atIndex:i+2] ;
    }
    
    // 调用NSInvocation对象
    [invocation invoke] ;
    
    // 获取返回值
    id res = nil ;
    
    // 判断方法是否有返回值
    if(signature.methodReturnLength!=0){
        [invocation getReturnValue:&res] ;
    }
    
    return res ;
}

@end
