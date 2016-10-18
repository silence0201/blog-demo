//
//  ViewController.m
//  shortAudioDemo
//
//  Created by 杨晴贺 on 7/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SIAudioTool.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SIAudioTool *tool = [SIAudioTool shareInstance] ;
    
    // 初始化加载文件
    [tool initialize] ;
    
    [tool playMp3:@"enemy1_down.mp3"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // c语言实现
    /*
        ios8音频播放bug
     */
    // 音频文件的url
    NSURL *soundUrl = [[NSBundle mainBundle] URLForResource:@"plane.bundle/enemy1_down.mp3" withExtension:nil] ;
    
    // 音频id , 一个音频文件对应一个soundID
    SystemSoundID soundID ;
    NSLog(@"%d",soundID) ;
    
    // 加载音频文件到内存中
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &soundID) ;
    
    // 播放音频
    AudioServicesPlaySystemSound(soundID) ;
    
}

@end
