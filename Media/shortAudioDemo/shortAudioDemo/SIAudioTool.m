//
//  SIAudioTool.m
//  shortAudioDemo
//
//  Created by 杨晴贺 on 7/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SIAudioTool.h"
static NSMutableDictionary *soundDic ;
@implementation SIAudioTool

+ (instancetype)shareInstance{
    static SIAudioTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(tool == nil){
            tool = [[SIAudioTool alloc]init] ;
            soundDic = [NSMutableDictionary dictionary] ;
        }
    });
    
    return tool ;
}

// 加载所有的音频文件
- (void)initialize{
    // 遍历所有的音频文件
    NSFileManager *mgr = [NSFileManager defaultManager] ;
    
    //获取bundle的路径
    NSString *planePath = [[NSBundle mainBundle]pathForResource:@"plane.bundle" ofType:nil] ;
    NSError *error = nil ;
    
    NSArray *names = [mgr contentsOfDirectoryAtPath:planePath error:&error] ;
    
    NSLog(@"%@",names) ;
    
    for(NSString *name in names){
        NSString *soundPath = [planePath stringByAppendingPathComponent:name] ;
        
        // URL
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath] ;
        
        SystemSoundID soundID ;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &soundID) ;
        
        [soundDic setValue:@(soundID) forKey:name] ;
    }
}

// 播放
- (void)playMp3:(NSString *)name{
    NSLog(@"%@",soundDic) ;
    SystemSoundID soundID = [[soundDic valueForKey:name] unsignedIntegerValue] ;
    NSLog(@"%d",soundID) ;
    if (soundID == 0) {
        return ;
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID) ;
    
}

@end
