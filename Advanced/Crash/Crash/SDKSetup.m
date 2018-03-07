//
//  SDKSetup.m
//  Crash
//
//  Created by Silence on 2018/3/7.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "XXShieldSDK.h"

#ifdef DEBUG
#define SILog(...)      printf("********************error start*************************\n[%s] %s [第%d行]\n%s\n*********************end********************************\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define SILog(...)
#endif

@interface SDKSetup : NSObject <XXRecordProtocol>

@end

@implementation SDKSetup

+ (void)load {
    [XXShieldSDK registerRecordHandler:[self new]];
    [XXShieldSDK registerStabilitySDK];
}

- (void)recordWithReason:(NSError *)reason {
    SILog(@"截获到一个错误:%@",reason.localizedDescription);
}

@end
