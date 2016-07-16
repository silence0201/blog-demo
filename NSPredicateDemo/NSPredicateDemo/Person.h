//
//  Person.h
//  NSPredicateDemo
//
//  Created by 杨晴贺 on 16/7/16.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *name ;
@property NSInteger age ;

// 构造方法
- (instancetype)initWithName:(NSString *)name andAge:(NSInteger)age ;
+ (instancetype)personWithName:(NSString *)name andAge:(NSInteger)age ;

@end
