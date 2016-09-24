//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "TwoViewController.h"

@interface ViewController ()

@property (nonatomic,strong) id subscriber ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Action
- (IBAction)btnAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    TwoViewController *two = [storyboard instantiateViewControllerWithIdentifier:@"Two"] ;
    
    two.subject = [RACSubject subject] ;
    [two.subject subscribeNext:^(id x) {
        NSLog(@"通知了ViewController") ;
    }] ;
    
    [self presentViewController:two animated:YES completion:nil] ;
    
}

- (IBAction)replaySubjectAction:(id)sender {
    // 创建信号
    RACReplaySubject *subject = [RACReplaySubject subject] ;
    
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者%@",x) ;
    }] ;
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者%@",x) ;
    }] ;
    
    // 发送信号
    [subject sendNext:@(1)] ;
    [subject sendNext:@(2)] ;
    
}


#pragma mark - RACSubject的简单使用
- (void)racSubjectUse{
    // RACSubject:信号提供者
    
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 订阅信号
    [subject subscribeNext:^(id x) {
        // block:当有数据发出的时候就会调用
        // block:处理数据
        NSLog(@"%@",x);
    }];
    // 发送信号
    [subject sendNext:@1];
    
    // 开发中，使用这个RACSubject代替代理
}

#pragma mark - 信号简单使用
- (void)simpleUse{
    // 核心:信号类
    // 信号类的作用:只要有数据改变,就会把数据包装成一个信号,传递出去
    // 只要有数据改变,就有信号发出
    // 数据发出,并不是信号类发出
    
    // 1. 创建信号createSignal:didSubscribe(block)
    // RACDisposable:取消订阅
    // RACSubscriber:发送数据
    
    // createSignal方法
    // 1.创建RACDynamicSignal
    // 2.把didSubscribe保存到RACDynamicSignal
    
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        _subscriber = subscriber ; // 存在引用这样就不能自动取消
        // block调用时刻:当信号被订阅的时候就会调用
        // block的作用:描述当前信号那些数据需要发送
        // 发送数据
        NSLog(@"调用了didSubscribe") ;
        
        // 通常:传递数据出去
        [subscriber sendNext:@(1)] ;
        
        // 调用订阅者的nextBlock
        
        // 如果信号 想要被取消 就必须返回一个RACDispose
        return [RACDisposable disposableWithBlock:^{
            // 信号什么时候取消: 1.自动取消,当一个信号的订阅者销毁的时候,就会自动取消 2.主动取消
            // block电泳时刻:一旦一个信号被取消订阅的时候就会调用
            // block作用,当信号取消订阅用于清空一些资源
            NSLog(@"取消订阅") ;
        }] ;
    }] ;
    
    // 订阅信号
    // 1. 创建订阅者
    // 2. 将blokc保存到订阅者里面
    
    // 只要订阅信号,就会返回一个取消信号的类
    RACDisposable *dsp =  [siganl subscribeNext:^(id x) {
        // block:只要内部发送数据,就会调用这个block
        NSLog(@"%@",x) ;
    }] ;
    
    // 取消订阅
    [dsp dispose] ;
    
    
    // RACSingle使用步骤
    // 1. 创建信号
    // 2. 订阅信号
    
    //RASingle底层实现
    // 1. 当一个信号被订阅,创建订阅者,并且吧nextBlock保存到订阅者里面
    // 2. [RACDynamicSignal subscribe:RACSubscriber]
    // 3. 调用RACDynamicSignal的didSubscribe
    // 4. [subscriber sendNext:@1];
    // 5. 拿到订阅者的nextBlock调用
}


@end
