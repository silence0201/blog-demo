//
//  UnitTests.m
//  UnitTests
//
//  Created by 杨晴贺 on 26/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnitTests : XCTestCase

@end

@implementation UnitTests

/// 方法在XCTestCase的测试方法调用之前调用，可以在测试之前创建在test case方法中需要用到的一些对象等
- (void)setUp {
    [super setUp];
}

/// 当测试全部结束之后调用tearDown方法，法则在全部的test case执行结束之后清理测试现场，释放资源删除不用的对象等
- (void)tearDown {
    [super tearDown];
}

/// 测试用例的例子，注意测试用例一定要test开头
- (void)testExample {
    NSLog(@"%s",__FUNCTION__) ;
}

/// 测试性能例子
- (void)testPerformanceExample {
    [self measureBlock:^{
        // 需要测试性能的代码
        NSInteger sum = 0  ;
        for (NSInteger i= 0 ; i < 1000 ; i++){
            sum += i ;
        }
    }];
}

@end
