//
//  AssertTest.m
//  XCTestDemo
//
//  Created by 杨晴贺 on 26/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AssertTest.h"

@interface AssertTestClass : NSObject

@end

@implementation AssertTestClass


- (NSInteger)getNumber{
    return 10 ;
}

- (void)cycle{
    NSInteger sum = 0 ;
    for (NSInteger i = 0 ; i < 100 ; i++){
        sum += i ;
        NSLog(@"%ld",sum) ;
    }
}

- (void)exceptionFun{
    float i = 0 ;
    float r = 10 ;
    if (i == 0) {
        @throw [[NSException alloc]initWithName:@"抛出异常" reason:@"0" userInfo:nil] ;
    }else{
        NSLog(@"%f", r / i );
    }
}


@end


@implementation AssertTest{
    id obj ;
    id nilObj ;
}

- (void)setUp{
    [super setUp] ;
    obj = [[AssertTestClass alloc]init] ;
}

- (void)testAssert{
    /// XCTFail(format…) 生成一个失败的测试；
    // XCTFail(@"Fail") ;
    
    /// XCTAssertNil(a1, format...)为空判断，a1为空时通过，反之不通过；
    XCTAssertNil(nilObj,@"obj不为空") ;
    
    /// XCTAssertNotNil(a1, format…)不为空判断，a1不为空时通过，反之不通过；
    XCTAssertNotNil(obj,@"obj为空") ;
    
    /// XCTAssert(expression, format...)当expression求值为TRUE时通过；
    XCTAssert(YES,@"当为TRUE时通过") ;
    
    /// XCTAssertTrue(expression, format...)当expression求值为TRUE时通过；
    XCTAssertTrue(YES,@"当为TRUE时通过") ;
    
    /// XCTAssertFalse(expression, format...)当expression求值为False时通过；
    XCTAssertFalse(NO,@"当为FALSE时通过") ;
    
    /// XCTAssertEqualObjects(a1, a2, format...)判断相等，[a1 isEqual:a2]值为TRUE时通过，其中一个不为空时，不通过；
    XCTAssertEqualObjects(NSStringFromClass([AssertTestClass class]), @"AssertTestClass",@"两个对象不相等") ;
    
    /// XCTAssertNotEqualObjects(a1, a2, format...)判断不等，[a1 isEqual:a2]值为False时通过；
    XCTAssertNotEqualObjects(NSStringFromClass([AssertTestClass class]), @"Test",@"两个对象相等") ;
    
    /// XCTAssertEqual(a1, a2, format...)判断相等（当a1和a2是 C语言标量、结构体或联合体时使用, 判断的是变量的地址，如果地址相同则返回TRUE，否则返回NO）；
    XCTAssertEqual([obj getNumber], 10,@"两个值不相等") ;
    
    /// XCTAssertNotEqual(a1, a2, format...)判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
    XCTAssertNotEqual([obj getNumber], 0,@"两个值相等") ;
    
    /// XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...)判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/-accuracy）以内相等时通过测试；
    XCTAssertEqualWithAccuracy(1.123, 1.156, 0.1,@"在误差范围内不相等") ;
    
    /// XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
    XCTAssertNotEqualWithAccuracy(1.123, 1.456, 0.1,@"在误差范围内相等") ;
    
    /// XCTAssertThrows(expression, format...)异常测试，当expression发生异常时通过；反之不通过；（很变态） XCTAssertThrowsSpecific(expression, specificException, format...) 异常测试，当expression发生specificException异常时通过；反之发生其他异常或不发生异常均不通过；
    XCTAssertThrows([obj exceptionFun],@"没有发生异常") ;
    
    /// XCTAssertNoThrow(expression, format…)异常测试，当expression没有发生异常时通过测试
    XCTAssertNoThrow([obj getNumber],@"发生异常") ;
}

- (void)testPerformanceCycle{
    [self measureBlock:^{
        [obj performSelector:@selector(cycle) withObject:nil] ;
    }] ;
}

@end
