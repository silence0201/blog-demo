//
//  TwitterConnection.m
//  OCMockDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//


#import "TwitterConnection.h"

@implementation TwitterConnection

- (NSArray *)fetchTweets{
    
    return @[];
}

+ (NSArray *)fetchTweets2{
    
    return @[];
}

- (void)fetchTweetsWithBlock:(void (^)(NSDictionary *, NSError *))block{
    
    block(@{@"hh":@"hh"},nil);
}

@end
