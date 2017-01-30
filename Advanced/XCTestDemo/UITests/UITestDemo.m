//
//  UITestDemo.m
//  XCTestDemo
//
//  Created by 杨晴贺 on 30/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UITestDemo : XCTestCase

@end

@implementation UITestDemo

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

/// 利用录制生成代码
- (void)testLogin{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *nameElementsQuery = [app.otherElements containingType:XCUIElementTypeStaticText identifier:@"Name:"];
    XCUIElement *textField = [[nameElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"Silence"];
    
    XCUIElement *textField2 = [[nameElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    [textField2 tap];
    [textField2 typeText:@"1234"];
    [app.buttons[@"Login"] tap];
    
}


@end
