//
//  UITests.m
//  UITests
//
//  Created by 杨晴贺 on 26/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UITests : XCTestCase

@end

@implementation UITests

/// 方法在XCTestCase的测试方法调用之前调用，可以在测试之前创建在test case方法中需要用到的一些对象等
- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

/// 当测试全部结束之后调用tearDown方法，法则在全部的test case执行结束之后清理测试现场，释放资源删除不用的对象等
- (void)tearDown {
    [super tearDown];
}

- (void)testUI {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    XCUIElementQuery *nameElementsQuery = [app.otherElements containingType:XCUIElementTypeStaticText identifier:@"Name:"];
    XCUIElement *textField = [[nameElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"Silence"];
    
    XCUIElement *textField2 = [[nameElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    [textField2 typeText:@"1234"];
    
    [[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.buttons[@"Login"] tap];
}

@end
