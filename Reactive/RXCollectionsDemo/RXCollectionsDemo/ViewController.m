//
//  ViewController.m
//  RXCollectionsDemo
//
//  Created by 杨晴贺 on 2017/4/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UITextField *another;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.text.rac_newTextChannel subscribe:self.another.rac_newTextChannel] ;
    [self.another.rac_newTextChannel subscribe:self.text.rac_newTextChannel] ;
    
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            NSInteger integer = [input integerValue];
//            for (NSInteger i = 0; i < integer; i++) {
//                [subscriber sendNext:@(i)];
//            }
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
//    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [command execute:@1];
//    [RACScheduler.mainThreadScheduler afterDelay:0.1
//                                        schedule:^{
//                                            [command execute:@2];
//                                        }];
//    [RACScheduler.mainThreadScheduler afterDelay:0.2
//                                        schedule:^{
//                                            [command execute:@3];
//                                        }];
    
//    RACSubject *subject = [RACSubject subject];
//    RACSubject *replaySubject = [RACReplaySubject subject];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
//        // Subscriber 1
//        [subject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 1 get a next value: %@ from subject", x);
//        }];
//        [replaySubject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 1 get a next value: %@ from replay subject", x);
//        }];
//        
//        // Subscriber 2
//        [subject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 2 get a next value: %@ from subject", x);
//        }];
//        [replaySubject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 2 get a next value: %@ from replay subject", x);
//        }];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
//        [subject sendNext:@"send package 1"];
//        [replaySubject sendNext:@"send package 1"];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
//        // Subscriber 3
//        [subject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 3 get a next value: %@ from subject", x);
//        }];
//        [replaySubject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 3 get a next value: %@ from replay subject", x);
//        }];
//        
//        // Subscriber 4
//        [subject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 4 get a next value: %@ from subject", x);
//        }];
//        [replaySubject subscribeNext:^(id x) {
//            NSLog(@"Subscriber 4 get a next value: %@ from replay subject", x);
//        }];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
//        [subject sendNext:@"send package 2"];
//        [replaySubject sendNext:@"send package 2"];
//    }];

    
//    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
//            [subscriber sendNext:@1];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
//            [subscriber sendNext:@2];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
//            [subscriber sendNext:@3];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
//            [subscriber sendCompleted];
//        }];
//        return nil;
//    }] publish];
//    [connection connect];
//    RACSignal *signal = connection.signal;
//    
//    NSLog(@"Signal was created.");
//    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 1 recveive: %@", x);
//        }];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 2 recveive: %@", x);
//        }];
//    }];
    
    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendNext:@2];
//        [subscriber sendNext:@3];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//    NSLog(@"Signal was created.");
//    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 1 recveive: %@", x);
//        }];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 2 recveive: %@", x);
//        }];
//    }];
    
//    RACReplaySubject *subject = [RACReplaySubject subject];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"1st Subscriber: %@", x);
//    }];
//    [subject sendNext:@1];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"2nd Subscriber: %@", x);
//    }];
//    [subject sendNext:@2];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"3rd Subscriber: %@", x);
//    }];
//    [subject sendNext:@3];
//    [subject sendCompleted];
    
    

//    RACBehaviorSubject *subject = [RACBehaviorSubject subject];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"1st Sub: %@", x);
//    }];
//    [subject sendNext:@1];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"2nd Sub: %@", x);
//    }];
//    [subject sendNext:@2];
//    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"3rd Sub: %@", x);
//    }];
//    [subject sendNext:@3];
//    [subject sendCompleted];
    
//    RACSubject *subject = [RACSubject subject];
//    
//    // Subscriber 1
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"1st Sub: %@", x);
//    }];
//    [subject sendNext:@1];
//    
//    // Subscriber 2
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"2nd Sub: %@", x);
//    }];
//    [subject sendNext:@2];
//    
//    // Subscriber 3
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"3rd Sub: %@", x);
//    }];
//    [subject sendNext:@3];
//    [subject sendCompleted];

//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendNext:@2];
//        [subscriber sendNext:@3];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//    NSLog(@"%@", signal.toArray.rac_sequence);   
//    
//    RACSequence *sequence = @[@1, @2, @3].rac_sequence;
//    RACSignal *signal = sequence.signal;
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
//    RACSequence *sequence = @[@1, @2, @3].rac_sequence;
//    NSNumber *sum = [sequence foldLeftWithStart:0 reduce:^id _Nullable(NSNumber * _Nullable accumulator, NSNumber * _Nullable value) {
//        return @(accumulator.integerValue + value.integerValue);
//    }];
//    NSLog(@"%@", sum);
    
    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendNext:@2];
//        [subscriber sendNext:@3];
//        [subscriber sendNext:@4];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//    
//    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
//        return ^(NSNumber *value, BOOL *stop) {
//            value = @(value.integerValue * value.integerValue);
//            return [RACSignal return:value];
//        };
//    }] ;
//    
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal: %@", x);
//    }];
//    [bindSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"bindSignal: %@", x);
//    }];
//    
//    RACSequence *sequence = [RACSequence sequenceWithHeadBlock:^id _Nullable{
//        return @1;
//    } tailBlock:^RACSequence * _Nonnull{
//        return [RACSequence sequenceWithHeadBlock:^id _Nullable{
//            return @2;
//        } tailBlock:^RACSequence * _Nonnull{
//            return [RACSequence return:@3];
//        }];
//    }];
//    
//    NSLog(@"Lazy:  %@", sequence.lazySequence);
//    NSLog(@"Eager: %@", sequence.eagerSequence);
//    NSLog(@"Lazy:  %@", sequence.lazySequence);
    
    
}


@end
