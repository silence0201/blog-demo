//
//  TwitterViewController.m
//  OCMockDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "TwitterViewController.h"

@implementation TwitterViewController

- (void)updateTweetView{
    NSArray *tweets = [_connection fetchTweets];
    if (tweets != nil) {
        for (Tweet *t in tweets){
            [_tweetView addTweet:t];
        }
    }
}

- (void)updateTweetView2{
    NSArray *tweets = [TwitterConnection fetchTweets2];
    if (tweets != nil) {
        for (Tweet *t in tweets){
            [_tweetView addTweet:t];
        }
    }
}

@end
