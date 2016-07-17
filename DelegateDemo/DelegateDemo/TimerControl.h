//
//  TimerControl.h
//  DelegateDemo
//
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdateAlterBlock)();
//委托的协议定义
@protocol TimeControlDelegate <NSObject>

- (void)updateAlter ;

@end

@interface TimerControl : NSObject

@property(nonatomic,weak) id<TimeControlDelegate> delegate ;
@property(nonatomic,copy) UpdateAlterBlock updateAlterBlock ;

- (void)startTheTimer ;

@end
