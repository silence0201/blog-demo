//
//  GCDDemo.m
//  MultThreadDemo
//
//  Created by 杨晴贺 on 26/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "GCDDemo.h"

@implementation GCDDemo

+ (void)gcdDemo1{
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0) ;
    
    // 异步执行,不是立即执行
    dispatch_async(queue, ^{
        for(int i = 0 ; i<10 ; i++ ){
            NSLog(@"%d==%@",i,[NSThread currentThread]) ;
        }
    }) ;
    
    NSLog(@"Ending") ;
    
    [NSThread sleepForTimeInterval:20] ;
}

+ (void)gcdDemo2{
    // 全局异步队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0) ;
    
    // 同步执行,立即执行
    dispatch_sync(queue, ^{
        for(int i = 0 ; i<10 ; i++ ){
            NSLog(@"%d==%@",i,[NSThread currentThread]) ;
        }
    }) ;
    NSLog(@"Ending") ;
}

+ (void)gcdDemo3 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"耗时操作 %@", [NSThread currentThread]);
        // 耗时操作之后，更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新 UI %@", [NSThread currentThread]);
        });
    });
}

// dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_SERIAL);
// dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
+ (void)gcdDemo4{
     dispatch_queue_t queue = dispatch_queue_create("com.silence.queue", DISPATCH_QUEUE_SERIAL);
    for(int i=0 ; i<10;i++){
        NSLog(@"start %d",i) ;
        dispatch_async(queue, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        }) ;
    }
    
    NSLog(@"Ending") ;
    [NSThread sleepForTimeInterval:20] ;
}

+ (void)gcdDemo5{
     dispatch_queue_t queue = dispatch_queue_create("silence", DISPATCH_QUEUE_SERIAL);
    for(int i=0 ; i<10;i++){
        NSLog(@"start %d",i) ;
        dispatch_sync(queue, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        }) ;
    }
    
    NSLog(@"Ending") ;
}

+ (void)gcdDemo6{
    dispatch_queue_t q = dispatch_queue_create("silence", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; ++i) {
        dispatch_async(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
    }
    
    NSLog(@"Ending") ;
    
    [NSThread sleepForTimeInterval:20] ;
}

+ (void)gcdDemo7{
    dispatch_queue_t queue = dispatch_queue_create("silence", DISPATCH_QUEUE_CONCURRENT) ;
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"Hello") ;
        }) ;
    }) ;
    NSLog(@"Ending") ;
}

+ (void)gcdDemo8{
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zu==%@",index,[NSThread currentThread]);
    });
    NSLog(@"done");
}

+ (void)group1{
    dispatch_group_t group = dispatch_group_create() ;
    
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务 1 %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);
    });

    dispatch_group_async(group, q, ^{
        NSLog(@"任务 3 %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, q, ^{
        NSLog(@"OVER %@", [NSThread currentThread]);
    });
    
    NSLog(@"come here");
    
    [NSThread sleepForTimeInterval:20] ;
}

+ (void)group2{
    // 1. 调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 2. 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    // dispatch_group_enter & dispatch_group_leave 必须成对出现
    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 1 %@", [NSThread currentThread]);
        
        // dispatch_group_leave 必须是 block 的最后一句
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);
        
        // dispatch_group_leave 必须是 block 的最后一句
        dispatch_group_leave(group);
    });
    
    // 4. 阻塞式等待调度组中所有任务执行完毕
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    // 5. 判断异步
    NSLog(@"OVER %@", [NSThread currentThread]);
}





@end
