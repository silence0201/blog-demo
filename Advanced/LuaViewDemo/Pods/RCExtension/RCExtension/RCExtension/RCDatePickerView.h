//
//  RCDatePickerView.h
//  HaitaoERP
//
//  Created by Developer on 15/7/13.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//  日期选择器

#import <UIKit/UIKit.h>

@class RCDatePickerView;

@protocol RCDatePickerViewDelegate<NSObject>

- (void)datePickerView:(RCDatePickerView*)picker didSelectTime:(NSString*)time;

@end


@interface RCDatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, weak) id<RCDatePickerViewDelegate>delegate;

- (void)showFromView:(UIView *)view;

@end

