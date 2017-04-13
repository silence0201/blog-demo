//
//  AppDelegate.m
//  CrashGetDemo
//
//  Created by 杨晴贺 on 2017/4/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#include <signal.h>
#include <execinfo.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initHandler] ;
    return YES;
}

- (void)initHandler {
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0,sizeof(newSignalAction));
    newSignalAction.sa_handler = &signalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGSEGV, &newSignalAction, NULL);
    sigaction(SIGFPE, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGPIPE, &newSignalAction, NULL);
    
    //异常时调用的函数
    NSSetUncaughtExceptionHandler(&handleExceptions);
}

void handleExceptions(NSException *exception) {
    NSLog(@"exception = %@",exception);
    NSLog(@"callStackSymbols = %@",[exception callStackSymbols]);
}

void signalHandler(int sig) {
    //最好不要写，可能会打印太多内容
    NSLog(@"signal = %d", sig);
}


@end
