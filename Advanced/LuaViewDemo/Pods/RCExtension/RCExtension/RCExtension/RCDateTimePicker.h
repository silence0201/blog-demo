 //
//  RCDateTimePicker.h
//  HaitaoERP
//
//  Created by Developer on 15/7/13.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//  日期.时间选择器

#import <UIKit/UIKit.h>

@class RCDateTimePicker;

@protocol RCDateTimeDelegate<NSObject>

- (void)picker:(RCDateTimePicker*)picker didSelectedTime:(NSString*)date;

@end


@interface RCDateTimePicker : UIView

@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, weak) id<RCDateTimeDelegate>delegate;

@end
