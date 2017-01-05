//
//  RCDatePickerView.m
//  HaitaoERP
//
//  Created by Developer on 15/7/13.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

#import "RCDatePickerView.h"

@implementation RCDatePickerView
{
    UIControl *_control;     /**< 辅助控制btn */
    UIView    *_contentView; /**< 放置 */
}

- (id)initWithFrame:(CGRect)frame {
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:screen_bounds];
    if (self) {
        [self configSubview];
        [_control addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)cancelAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _contentView.frame;
        frame.origin.y += _contentView.frame.size.height;
        _contentView.frame = frame;
        _control.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showFromView:(UIView *)view {
    _control.alpha = 0;
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    _contentView.frame = CGRectMake(0, screen_bounds.size.height, screen_bounds.size.width, 270);
    [view addSubview:self];
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.9 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect frame = _contentView.frame;
        frame.origin.y -= (_contentView.frame.size.height-20);
        _contentView.frame = frame;
        _control.alpha = 0.4;
    } completion:^(BOOL finished) {

    }];
}
- (void)actionConfirm:(id)sender {
    if ([self.delegate respondsToSelector:@selector(datePickerView:didSelectTime:)]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd "];
        NSString *strDate = [dateFormatter stringFromDate:_datePicker.date];
        [self.delegate datePickerView:self didSelectTime:strDate];
    }
    [self cancelAction];
}

- (void)configSubview {
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    _control = [[UIControl alloc]initWithFrame:self.frame];
    _control.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35f];
    [self addSubview:_control];
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_bounds.size.height-250, screen_bounds.size.width, 270)];
    _contentView.backgroundColor = [UIColor whiteColor];
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.date = [NSDate date];
    _datePicker.frame = CGRectMake(0, 0, screen_bounds.size.width, 250);
    [_contentView addSubview:_datePicker];

    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screen_bounds.size.width, 40)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionConfirm:)];
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:itemCancel, space, itemDone, nil]];
    [_contentView addSubview:toolbar];
    [self insertSubview:_contentView aboveSubview:_control];
}



@end
