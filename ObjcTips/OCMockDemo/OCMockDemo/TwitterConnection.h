//
//  TwitterConnection.h
//  OCMockDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface TwitterConnection : NSObject

- (NSArray *)fetchTweets;

+ (NSArray *)fetchTweets2;


- (void)fetchTweetsWithBlock:(void (^)(NSDictionary *result, NSError *error))block;

@end
