//
//  ExceptionHandler.m
//  ExceptionHandlerDemo
//
//  Created by 杨晴贺 on 2017/4/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;


void HandleException(NSException *exception);
void SignalHandler(int signal);
NSString* getAppInfo();

@interface ExceptionHandler()
@property (nonatomic,assign) BOOL dismissed;
@end

@implementation ExceptionHandler

+ (void)installExceptionHandler:(BOOL)install {
    NSSetUncaughtExceptionHandler(install ? HandleException : NULL);
    signal(SIGABRT, install ? SignalHandler : SIG_DFL); //
    signal(SIGILL, install ? SignalHandler : SIG_DFL);  // kill信号
    signal(SIGSEGV, install ? SignalHandler : SIG_DFL); // 段错误
    signal(SIGFPE, install ? SignalHandler : SIG_DFL);  //
    signal(SIGBUS, install ? SignalHandler : SIG_DFL);  // 总线错误
    signal(SIGPIPE, install ? SignalHandler : SIG_DFL); // 坏的管道
}

// 获取调用堆栈
+ (NSArray<NSString *> *)backtrace {
    // 指针列表
    void* callstack[128];
    // backtrace用来获取当前线程的调用堆栈，获取的信息存放在这里的callstack中
    // 128用来指定当前的buffer中可以保存多少个void*元素
    // 返回值是实际获取的指针个数
    int frames = backtrace(callstack, 128);
    // backtrace_symbols将从backtrace函数获取的信息转化为一个字符串数组
    // 返回一个指向字符串数组的指针
    // 每个字符串包含了一个相对于callstack中对应元素的可打印信息，包括函数名、偏移地址、实际返回地址
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

// 处理报错信息
- (void)validateAndSaveCriticalApplicationData:(NSException *)exception {
    NSString *exceptionInfo = [NSString stringWithFormat:@"\n--------Log Exception---------\nappInfo             :\n%@\n\nexception name      :%@\nexception reason    :%@\nexception userInfo  :%@\ncallStackSymbols    :%@\n\n--------End Log Exception-----", getAppInfo(),exception.name, exception.reason, exception.userInfo ? : @"no user info", [exception callStackSymbols]];
    NSLog(@"%@", exceptionInfo);
}

- (void)handleException:(NSException *)exception {
    [self validateAndSaveCriticalApplicationData:exception];
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    } else {
        [exception raise];
    }
}

void HandleException(NSException *exception) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
#pragma clang diagnostic pop
    // 如果太多不用处理
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    //获取调用堆栈
    NSArray *callStack = [exception callStackSymbols];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    
    //在主线程中，执行制定的方法, withObject是执行方法传入的参数
    [[[ExceptionHandler alloc] init]performSelectorOnMainThread:@selector(handleException:)
                                                     withObject:[NSException exceptionWithName:[exception name]
                                                         reason:[exception reason]
                                                       userInfo:userInfo] waitUntilDone:YES];
}

//处理signal报错
void SignalHandler(int signal) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
#pragma clang diagnostic pop    
    // 如果太多不用处理
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    NSString* description = nil;
    switch (signal) {
        case SIGABRT:
            description = [NSString stringWithFormat:@"Signal SIGABRT was raised!\n"];
            break;
        case SIGILL:
            description = [NSString stringWithFormat:@"Signal SIGILL was raised!\n"];
            break;
        case SIGSEGV:
            description = [NSString stringWithFormat:@"Signal SIGSEGV was raised!\n"];
            break;
        case SIGFPE:
            description = [NSString stringWithFormat:@"Signal SIGFPE was raised!\n"];
            break;
        case SIGBUS:
            description = [NSString stringWithFormat:@"Signal SIGBUS was raised!\n"];
            break;
        case SIGPIPE:
            description = [NSString stringWithFormat:@"Signal SIGPIPE was raised!\n"];
            break;
        default:
            description = [NSString stringWithFormat:@"Signal %d was raised!",signal];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSArray *callStack = [ExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    [userInfo setObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    
    //在主线程中，执行指定的方法, withObject是执行方法传入的参数
    [[[ExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                      withObject:[NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                                                                         reason:description
                                                                                       userInfo:userInfo]
                                                   waitUntilDone:YES];
}

NSString* getAppInfo() {
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    return appInfo;
}

@end
