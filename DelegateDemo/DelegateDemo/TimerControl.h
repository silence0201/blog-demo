//
//  TimerControl.h
//  DelegateDemo
//
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdateAlterBlock)();
//指定代理的需要遵守的协议
@protocol TimeControlDelegate <NSObject>

// 必须要实现
@required
- (void)updateAlter ;

// 可选实现
@optional
- (void)test ;

@end

@interface TimerControl : NSObject

// 指定对应的代理属性
@property(nonatomic,weak) id<TimeControlDelegate> delegate ;

@property(nonatomic,copy) UpdateAlterBlock updateAlterBlock ;

- (void)startTheTimer ;

@end
