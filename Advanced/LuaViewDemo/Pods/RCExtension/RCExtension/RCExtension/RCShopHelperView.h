//
//  RCShopHelperView.h
//  RCShopHelper
//
//  Created by 游侠 on 15/8/23.
//  Copyright © 2015年 YL. All rights reserved.
//  购物车 加减号控件

#import <UIKit/UIKit.h>

@protocol ShopCountDelegate <NSObject>

- (void)valueChanged:(NSInteger)count;

@end

@interface  RCShopHelperView : UIView

@property (weak, nonatomic)   id<ShopCountDelegate> delegate ;

@property (nonatomic, strong)  UIButton *minusButton;
@property (nonatomic, strong)  UILabel *countLabel;
@property (nonatomic, strong)  UIButton *plusButton;

@property (nonatomic, strong)  UIImage *minusImage;
@property (nonatomic, strong)  UIImage *minusDefaultImage;
@property (nonatomic, strong)  UIImage *plusImage;
@property (nonatomic, strong)  UIImage *plusDesenableImage;

@property (nonatomic, assign)  NSInteger count;
@property (nonatomic, assign)  NSInteger  maxCount;

@end
