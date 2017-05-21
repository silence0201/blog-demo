//
//  OCMockDemoTests.m
//  OCMockDemoTests
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Person.h"
#import "TwitterViewController.h"
#import "TwitterConnection.h"
#import "TweetView.h"
#import "Tweet.h"

@interface OCMockDemoTests : XCTestCase

@end

@implementation OCMockDemoTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// 简单使用OCMock的例子
- (void)testPersonNameEqual {
    Person *person = [[Person alloc]init] ;
    // 创建一个Mock对象
    id mockClass = OCMClassMock([Person class]) ;
    // 可以给这个mock兑现改的方法设置预设的参数和返回值
    OCMStub([mockClass getPersonName]).andReturn(@"齐滇大圣");
    // 用这个预设值和实际值进行比较是否相等
    XCTAssertEqualObjects([mockClass getPersonName], [person getPersonName],@"请确保值相等" );
}

// 验证方法是或否调用
- (void)testDisplaysTweetsRetrievedFromConnection {
    TwitterViewController *controller = [[TwitterViewController alloc] init];
    
    // 模拟出来一个网络连接请求的数据类
    id mockconnection = OCMClassMock([TwitterConnection class]) ;
    controller.connection = mockconnection ;
    
    // 模拟fectTweets方法返回预设值
    Tweet *testTweet = [[Tweet alloc]init] ;
    testTweet.userName = @"齐滇大圣";
    Tweet *testTweet2 = [[Tweet alloc] init];
    testTweet2.userName = @"美猴王";
    NSArray *tweetArray = @[testTweet,testTweet2];
    OCMStub([mockconnection fetchTweets]).andReturn(tweetArray);
    
    // 模拟出来一个view类
    id mockView = OCMClassMock([TweetView class]);
    controller.tweetView = mockView;
    
    // 这里执行updateTweetView之后，[mockView addTweet:]加入了testTweet和testTweet2
    [controller updateTweetView];
    
    
    // 验证使用对应参数的方法是否被调用
    OCMVerify([mockView addTweet:testTweet]);
    OCMVerify([mockView addTweet:testTweet2]);
    OCMVerify([mockView addTweet:[OCMArg any]]);
    
    // 不通过
    // Tweet *testTweet3 = [[Tweet alloc] init];
    // testTweet3.userName = @"斗战胜佛";
    // OCMVerify([mockView addTweet:testTweet3]);
}

// 验证方法调用
- (void)testAndDo {
    static BOOL isCanced = false ;
    id mockClass = OCMClassMock([TwitterViewController class]) ;
    OCMStub([mockClass viewDidLoad]).andDo(^(NSInvocation *invocation){
        isCanced = YES;
    });
    XCTAssertFalse(isCanced);
}


@end
