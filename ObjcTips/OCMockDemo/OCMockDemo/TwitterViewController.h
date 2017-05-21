//
//  TwitterViewController.h
//  OCMockDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterConnection.h"
#import "TweetView.h"

@interface TwitterViewController : UIViewController

@property(nonatomic, strong)TwitterConnection *connection;
@property(nonatomic, strong)TweetView         *tweetView;

- (void)updateTweetView;

- (void)updateTweetView2;

@end
