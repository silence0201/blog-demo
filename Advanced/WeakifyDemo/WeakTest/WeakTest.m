//
//  WeakTest.m
//  WeakTest
//
//  Created by 杨晴贺 on 05/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXTScope.h"

@interface WeakTest : XCTestCase

@end

@implementation WeakTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testWeakifyUnsafeifyStrongify {
    void (^verifyMemoryManagement)(void);
    
    @autoreleasepool {
        NSString *foo __attribute__((objc_precise_lifetime)) = [@"foo" mutableCopy];
        NSString *bar __attribute__((objc_precise_lifetime)) = [@"bar" mutableCopy];
        
        void *fooPtr = &foo;
        void *barPtr = &bar;
        
        @weakify(foo);
        @unsafeify(bar);
        
        BOOL (^matchesFooOrBar)(NSString *) = ^ BOOL (NSString *str){
            @strongify(bar, foo);
            
            XCTAssertEqualObjects(foo, @"foo", @"");
            XCTAssertEqualObjects(bar, @"bar", @"");
            
            XCTAssertTrue(fooPtr != &foo, @"Address of 'foo' within block should be different from its address outside the block");
            XCTAssertTrue(barPtr != &bar, @"Address of 'bar' within block should be different from its address outside the block");
            
            return [foo isEqual:str] || [bar isEqual:str];
        };
        
        XCTAssertTrue(matchesFooOrBar(@"foo"), @"");
        XCTAssertTrue(matchesFooOrBar(@"bar"), @"");
        XCTAssertFalse(matchesFooOrBar(@"buzz"), @"");
        
        verifyMemoryManagement = [^{
            // Can only strongify the weak reference without issue.
            @strongify(foo);
            XCTAssertNil(foo, @"");
        } copy];
    }
    
    verifyMemoryManagement();
}



@end
