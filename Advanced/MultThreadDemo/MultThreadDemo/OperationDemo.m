//
//  OperationDemo.m
//  MultThreadDemo
//
//  Created by 杨晴贺 on 26/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OperationDemo.h"

@implementation OperationDemo

+ (void)OperationDemo1 {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
    // start方法 会在当前线程执行 @selector 方法
    [op start];
}

+ (void)downloadImage:(id)obj {
    NSLog(@"%@ %@", [NSThread currentThread], obj);
}

+ (void)OperationDemo2 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"queue"];
    [q addOperation:op];
}

+ (void)OperationDemo3 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    for (int i = 0; i < 10; ++i) {
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@(i)];
        [q addOperation:op];
    }
}

+ (void)OperationDemo4 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    [q addOperation:op];
}

@end
