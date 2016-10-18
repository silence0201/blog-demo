//
//  SIAudioTool.h
//  shortAudioDemo
//
//  Created by 杨晴贺 on 7/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SIAudioTool : NSObject
// 单例对象
+ (instancetype) shareInstance ;
// 加载文件
- (void)initialize ;
- (void)playMp3:(NSString *)name ;
@end
