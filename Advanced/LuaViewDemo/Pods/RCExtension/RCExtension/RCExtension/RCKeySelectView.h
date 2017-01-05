//
//  RCKeySelectView.h
//  HTlvyou_ERP
//
//  Created by Developer on 15/8/24.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//  有取值key 的选择器 类似于 RCSelectView

#import <UIKit/UIKit.h>

@class RCListButton;

@protocol KeySelectDelegate <NSObject>

- (void)updateTitleAtRow:(NSInteger)row;

@end

@interface RCKeySelectView : UIView

@property (weak, nonatomic)   id<KeySelectDelegate>delegate;
@property (nonatomic, copy)   NSString *key;

- (void)showListViewIn:(UIView *)superView WithArray:(NSArray *)array title:(NSString *)title;

@end
