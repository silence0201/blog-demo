//
//  MyClass.h
//  test
//
//  Created by 杨晴贺 on 8/19/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject


@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

- (void)method1;

- (void)method2;

+ (void)classMethod1;


@end
